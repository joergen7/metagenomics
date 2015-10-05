name             'metagenomics'
maintainer       "Jörgen Brandt"
maintainer_email "brandjoe@hu-berlin.de"
license          'all_rights'
description      'Installs/Configures metagenomics'
long_description 'Installs/Configures metagenomics'
version          '0.1.0'

recipe "metagenomics::_common", "Performs an update of the package system."
recipe "metagenomics::default", "Sets up all preconditions to run the metagenomics workflow."


depends "chef-bioinf-worker"
depends "chef-cuneiform"
