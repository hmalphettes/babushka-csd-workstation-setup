dep 'CSD Workstation Setup' do
  requires 'Update Apple Store', # that one is annoying: it wants a password
  			'homebrew', 'rubygems', 'Google Chrome.app', 'Firefox.app',
  			'VirtualBox.installer', 
  			#'spork:TextMate', 'spork:GitX', 'spork:MacVim',
  			'iTerm.app', 'SourceTree.app', 'VMware Fusion.app', 'MenuMeters.app',# 'Skype.app',
  			'Eclipse.tgz'
end

dep 'Google Chrome.app' do
	source 'http://dl.google.com/chrome/mac/dev/GoogleChrome.dmg'
end

dep 'Firefox.app' do
	source 'http://download.cdn.mozilla.net/pub/mozilla.org/firefox/releases/17.0.1/mac/en-US/Firefox%2017.0.1.dmg'
end

dep 'VirtualBox.installer' do
	source 'http://download.virtualbox.org/virtualbox/4.2.4/VirtualBox-4.2.4-81684-OSX.dmg'
end

dep 'VMware Fusion.app' do
	source 'file:///' + Dir.pwd + '/downloads/VMware-Fusion-5.0.2-900491-light.dmg'
end

dep 'SourceTree.app' do
	source 'http://downloads.atlassian.com/software/sourcetree/SourceTree_1.5.6.dmg'
end

dep 'iTerm.app' do
	source 'http://iterm2.googlecode.com/files/iTerm2_v1_0_0.zip'
end

#dep 'Skype.app' do
#	source 'http://www.skype.com/go/getskype-macosx.dmg'
#end

dep 'MenuMeters.app' do
	source 'http://www.ragingmenace.com/software/download/MenuMeters.dmg'
end

dep 'Eclipse.tgz' do
	meet do
		shell <<-EOH
		brew install wget
		wget -O eclipse-jee-juno-SR1-macosx-cocoa-x86_64.tar.gz 'http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/juno/SR1/eclipse-jee-juno-SR1-macosx-cocoa-x86_64.tar.gz&url=http://download.nus.edu.sg/mirror/eclipse//technology/epp/downloads/release/juno/SR1/eclipse-jee-juno-SR1-macosx-cocoa-x86_64.tar.gz&mirror_id=1136'
		tar -xzf eclipse-jee-juno-SR1-macosx-cocoa-x86_64.tar.gz
		mv eclipse /Applications
		EOH
	end
	met? do
		"/Applications/eclipse".p.exists?.tap {|result|
      		log "met?: #{result}."
      	}
    end
end

dep 'Update Apple Store' do
	meet do
		shell = "softwareupdate -i -a"
	end
	met? do
		`sudo softwareupdate --schedule | grep on`
	end
end

