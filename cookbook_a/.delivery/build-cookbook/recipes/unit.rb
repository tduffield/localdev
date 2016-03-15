#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
for i in 1..10
  log "Iteration #{i}"

  execute 'sleep 5'
end
