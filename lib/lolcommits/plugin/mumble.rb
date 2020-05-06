# frozen_string_literal: true

require 'lolcommits/plugin/base'
require 'rest_client'
require 'base64'
require 'uri'

module Lolcommits
  module Plugin
    class Mumble < Base
      # Mumble API File upload endpoint

      # Number of times to retry if RestClient.post fails
      RETRY_COUNT = 2

      ##
      # Capture ready hook, runs after lolcommits captures a snapshot.
      #
      # Uses `RestClient` to post the lolcommit to (one or more) Mumble
      # channels. Posting will be retried (`RETRY_COUNT`) times if any
      # error occurs.
      #
      # The post contains the git commit message, repo name and the SHA
      # is used for the filename. The response from the POST
      # request is sent to the debug log.
      #
      def run_capture_ready
        retries = RETRY_COUNT
        begin
          print "Posting to Mumble ... "
          print runner.lolcommit_path
          file = File.binread(runner.lolcommit_path)
          encoded = Base64.encode64(file)
          message = URI::encode("<img src=\"data:image/jpg;base64,%s \" />" % [encoded])
          response = RestClient.post(
            "%s/servers/%d/sendmessage" % [configuration[:url], configuration[":serverid:"]],
            message: message
          )
          debug response
          print "done!\n"
        rescue => e
          retries -= 1
          print "failed! #{e.message}"
          if retries > 0
            print " - retrying ...\n"
            retry
          else
            print " - giving up ...\n"
            puts 'Try running config again:'
            puts "\tlolcommits --config -p mumble"
          end
        end
      end

      ##
      # Prompts the user to configure integration with Mumble
      #
      # Prompts user for a Mumble `access_token` and a comma seperated
      # list of valid Mumble channel IDs.
      #
      # @return [Hash] a hash of configured plugin options
      #
      def configure_options!
        options = super

        if options[:enabled]
          print "enter the url of the server, then press enter: (e.g. xxxx-xxxxxxxxx-xxxx) \n"
          url = parse_user_input(gets.strip)

          print "enter a server id\n"
          print "note: to see server id, use the following REST call: %s/servers\n" % [url]
          serverIdS = parse_user_input(gets.strip)
          serverId = serverIdS.to_i

          print "enter a channel id\n"
          print "note: to see channel id, use the following REST call: %s/servers/%d/channels\n" % [url, serverId]
          channelIdS = parse_user_input(gets.strip)
          channelId = channelIdS.to_i

          options.merge!(
            url: url,
            server_id: serverId,
            channel_id: channelId
          )
        end

        options
      end
    end
  end
end
