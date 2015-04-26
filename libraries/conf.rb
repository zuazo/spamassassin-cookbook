# encoding: UTF-8
#
# Cookbook Name:: onddo-spamassassin
# Library:: conf
# Author:: Xabier de Zuazo (<xabier@onddo.com>)
# Copyright:: Copyright (c) 2013-2015 Onddo Labs, SL. (www.onddo.com)
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Chef SpamAssassin Cookbook libraries top class.
module SpamAssassinCookbook
  # Chef SpamAssasssin Cookbook configuration helpers.
  module Conf
    def self.value(v)
      if v.is_a?(TrueClass)
        '1'
      elsif v.is_a?(FalseClass)
        '0'
      else
        v.to_s
      end
    end
  end
end
