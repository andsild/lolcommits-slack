# frozen_string_literal: true

require 'test_helper'

describe Lolcommits::Plugin::Mumble do

  include Lolcommits::TestHelpers::GitRepo
  include Lolcommits::TestHelpers::FakeIO

  describe 'with a runner' do

    def runner
      # a simple lolcommits runner
      @_runner ||= Lolcommits::Runner.new(
        lolcommit_path: Tempfile.new('lolcommit.jpg')
      )
    end

    def plugin
      @_plugin ||= Lolcommits::Plugin::Mumble.new(runner: runner)
    end

    def valid_enabled_config
      {
        enabled: true,
        url: 'qwde.no:8080',
        channel: '1'
      }
    end

    describe '#run_capture_ready' do
      before do
        commit_repo_with_message
      end

      it 'should post the message to mumble' do
        stub_request(:any, "qwde.no:8080")
        in_repo do
          plugin.configuration = valid_enabled_config
          output = fake_io_capture { plugin.run_capture_ready }
          assert_equal output, "Posting to Mumble ... done!\n"

          assert_requested :post, "qwde.no:8080",
            headers: { 'Content-Type' => /multipart\/form-data;/ },
            times: 1
        end
      end

      it 'should retry (and explain) if there is a failure (req timeout)' do
        in_repo do
          stub_request(:any, "qwde.no:8080").to_timeout
          plugin.configuration = valid_enabled_config

          _(Proc.new { plugin.run_capture_ready }).
            must_output("Posting to Mumble ... failed! Timed out connecting to server - retrying ...\nPosting to Mumble ... failed! Timed out connecting to server - giving up ...\nTry running config again:\n\tlolcommits --config -p mumble\n")

          assert_requested :post, "qwde.no:8080",
            headers: { 'Content-Type' => /multipart\/form-data;/ },
            times: plugin.class::RETRY_COUNT
        end
      end

      after { teardown_repo }
    end

    describe '#enabled?' do
      it 'should be false by default' do
        _(plugin.enabled?).must_equal false
      end

      it 'should true when configured' do
        plugin.configuration = valid_enabled_config
        _(plugin.enabled?).must_equal true
      end
    end

    describe 'configuration' do
      it 'should allow plugin options to be configured' do
        configured_plugin_options = {}

        fake_io_capture(inputs: %w(true qwde.no:8080 1 1)) do
          configured_plugin_options = plugin.configure_options!
        end

        _(configured_plugin_options).must_equal({
          enabled: true,
          url: 'qwde.no:8080',
          channel_id: 1,
          server_id: 1
        })
      end

      describe '#valid_configuration?' do
        it 'should be false without config set' do
          _(plugin.valid_configuration?).must_equal(false)
        end

        it 'should be true for a valid configuration' do
          plugin.configuration = valid_enabled_config
          _(plugin.valid_configuration?).must_equal true
        end
      end
    end
  end
end
