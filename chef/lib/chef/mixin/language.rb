#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2008 OpsCode, Inc.
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

class Chef
  module Mixin
    module Language

      # Given a hash similar to the one we use for Platforms, select a value from the hash.  Supports
      # per platform defaults, along with a single base default.
      #
      # === Parameters
      # platform_hash:: A platform-style hash.
      #
      # === Returns
      # value:: Whatever the most specific value of the hash is.
      def value_for_platform(platform_hash)
        result = nil
        
        if platform_hash.has_key?(@node[:platform])
          if platform_hash[@node[:platform]].has_key?(@node[:platform_version])
            result = platform_hash[@node[:platform]][@node[:platform_version]]
          elsif platform_hash[@node[:platform]].has_key?("default")
            result = platform_hash[@node[:platform]]["default"]
          end
        end
  
        unless result
          if platform_hash.has_key?("default")
            result = platform_hash["default"]
          end
        end  
  
        result
      end

      # Given a list of platforms, returns true if the current recipe is being run on a node with
      # that platform, false otherwise.
      #
      # === Parameters
      # args:: A list of platforms
      #
      # === Returns
      # true:: If the current platform is in the list
      # false:: If the current platform is not in the list
      def platform?(*args)
        has_platform = false
  
        args.flatten.each do |platform|
          has_platform = true if platform == @node[:platform]
        end
  
        has_platform
      end
      
    end
  end
end