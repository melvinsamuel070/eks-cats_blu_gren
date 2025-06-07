# config/puma.rb
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

rackup DefaultRackup
port ENV.fetch("PORT") { 8000 }
environment ENV.fetch("RACK_ENV") { "development" }

preload_app!