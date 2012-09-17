./create_master.rb

for i in {1..15}; do (./create_app.rb ip-10-170-94-107.us-west-1.compute.internal &) && sleep 2; done
