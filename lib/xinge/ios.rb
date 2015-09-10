require 'xinge/base'
module Xinge
  class Ios < Base

    ENV_MAP = {'production' => 1, 'development' => 2, 'staging' => 2}
    ENV_VAL = ENV_MAP[Xinge.config[:env]]

    def initialize(accessId = nil, secretKey = nil, options = {})
      super
    end

    # send_time: 指定推送时间，格式为year-mon-day hour:min:sec 若小于服务器当前时间，则会立即推送
    def push_to_single_device(token, title, content, params={}, custom_content={}, send_time='')
      self.push_single_device(token, 0, build_simple_message(title, content, custom_content), params.merge({environment: ENV_VAL, send_time: send_time}))
    end

    def push_to_all_device(title, content, params={}, custom_content={}, send_time='')
      self.push_all_device(0, build_simple_message(title, content, custom_content), params.merge({environment: ENV_VAL, send_time: send_time}))
    end

    def push_to_single_account(account, title, content, params={}, custom_content={}, send_time='')
      self.push_single_account(account, 2, build_simple_message(title, content, custom_content), params.merge({environment: ENV_VAL, send_time: send_time}))
    end

    def push_to_tags_device(title, content, tags, params={}, custom_content={}, tag_op='OR', send_time='')
      self.push_tags_device(0, build_simple_message(title, content, custom_content), tags, tag_op, params.merge({environment: ENV_VAL, send_time: send_time}))
    end

    protected

    def build_simple_message(title, content, custom_content)
      {
        aps: {
          alert: {
            title: title,
            body: content
          },
          sound: 'default',
          badge: 1
        }
      }.merge(custom_content).to_json
    end
  end
end
