require 'xinge/base'
module Xinge
  class Android < Base
    def initialize(accessId = nil, secretKey = nil, options = {})
      super
    end

    def push_to_single_device(token, title, content, params={}, custom_content={})
      self.push_single_device(token, 1, build_simple_message(title, content, custom_content), params)
    end

    def push_to_all_device(title, content, params={}, custom_content={})
      self.push_all_device(1, build_simple_message(title, content, custom_content), params)
    end

    def push_to_single_account(account, title, content, params={}, custom_content={})
      self.push_single_account(account, 1, build_simple_message(title, content, custom_content), params)
    end

    def push_to_tags_device(title, content, tags, params={}, custom_content={}, tag_op='OR')
      self.push_tags_device(1, build_simple_message(title, content, custom_content), tags, tag_op, params)
    end

    protected

    def build_simple_message(title, content, custom_content)
      {
        title: title, content: content, vibrate: 1
      }.merge(custom_content).to_json
    end
  end
end
