
alias mount_crypt="encfs ~/.crypt ~/crypt"
alias umount_crypt="fusermount -u ~/crypt"
alias mount-securedrop="encfs ~/Dropbox/securedrop/ ~/securedrop"
alias umount-securedrop="fusermount -u ~/securedrop"


alias tunnel-hudson="mssh rchyla@pogo1.cfa.harvard.edu rchyla@adsate.cfa.harvard.edu -L9091:adsate.cfa.harvard.edu:9090"
alias foxyproxy='ssh -f -N -L 9998:adsset.cfa.harvard.edu:22 pogo3.cfa.harvard.edu; ssh -f -N -D 9999 localhost -p 9998'
alias adsxmysqltunnel='ssh -N -f -L 3307:adsx.cfa.harvard.edu:3306 pogo3.cfa.harvard.edu'
alias st=/dvt/subtext/sublime_text
alias rabbitmqtunnel='ssh -N -f -L 15672:adsx.cfa.harvard.edu:15672 pogo3.cfa.harvard.edu'
alias mongotunnel='ssh -N -f -L 27018:adsx.cfa.harvard.edu:27017 pogo3.cfa.harvard.edu'
alias psqltunnel='ssh -N -f -L 5433:adsx.cfa.harvard.edu:5432 pogo3.cfa.harvard.edu'
alias consultunnel='ssh -t -L 8501:localhost:8501 rchyla@pogo3.cfa.harvard.edu ssh -t -L 8501:localhost:8501 rchyla@adsx.cfa.harvard.edu ssh -i ~/.ssh/micro.pem -L 8501:consul.adsabs:8500 ec2-user@52.0.152.20'
alias solrtunnel='ssh -t -L 8984:localhost:8984 rchyla@pogo3.cfa.harvard.edu ssh -t -L 8984:localhost:8984 rchyla@adsx.cfa.harvard.edu ssh -i ~/.ssh/micro.pem -L 8984:solr-searcher.adsabs:8983 ec2-user@52.0.152.20'
alias kibanatunnel='ssh -t -L 5601:localhost:5601 rchyla@pogo3.cfa.harvard.edu ssh -t -L 5601:localhost:5601 rchyla@adsx.cfa.harvard.edu ssh -i ~/.ssh/micro.pem -L 5601:elastickibana.adsabs:5601 ec2-user@52.0.152.20'


alias ox='xdg-open'
alias webstorm-fix-keyboard="sudo ibus restart"
