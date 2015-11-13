class Facter::Util::Lspci

  def self.run(command = "lspci 2>/dev/null")
    Facter::Util::Resolution.exec command
  end

  def self.match(regex)
    if Facter::Util::Resolution::which('lspci')
      output = self.run
      matches = output.scan(regex)
      matches.flatten.reject {|s| s.nil?}.length
    end
  end

end
