Facter.add('master') do
  setcode do
    if `ec2metadata --security-groups`.strip.to_s == "master"
      `hostname -f`.strip.to_s
    else
      "help!"
    end
  end
end
Facter.add('type') do
  setcode do
    `ec2metadata --security-groups`.strip.to_s
  end
end
