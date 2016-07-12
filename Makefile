BUNDLE_VERSION = 1.7.15
BUNDLE = bundle _${BUNDLE_VERSION}_
BUNDLE_OPTIONS = -j 3
RSPEC = rspec
APPRAISAL = appraisal

default: test

test: appraisal
	${BUNDLE} exec ${APPRAISAL} ${RSPEC} spec 2>&1

appraisal: bundle
	${BUNDLE} exec ${APPRAISAL} install

bundle:
	gem list -i -v ${BUNDLE_VERSION} bundler > /dev/null || gem install bundler --no-ri --no-rdoc --version=${BUNDLE_VERSION}
	${BUNDLE} check || ${BUNDLE} install ${BUNDLE_OPTIONS}

