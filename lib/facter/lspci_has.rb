require 'facter/util/lspci'

Facter.add(:lspci_has, :type => :aggregate) do
  confine :kernel => "Linux"

  chunk(:intel82599sfp) do
    count = Facter::Util::Lspci.match(/Intel.*82599ES.*SFP\+/)
    { "intel82599sfp" => count > 0 }
  end

end
