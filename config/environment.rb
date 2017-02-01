require 'rubygems'
require 'bundler'
env = ENV['APP_ENV'] || :development
Bundler.setup(:default, env)
Bundler.require

$:.unshift(File.expand_path('../../lib', __FILE__))

require 'celluloid/websocket/client'
require 'json'
require 'openssl'
require 'logger'

require 'loxone'
require 'use_case'
require 'canvas'
require 'printer'
require 'effect'

require ::File.expand_path("../environments/#{env}",  __FILE__)
