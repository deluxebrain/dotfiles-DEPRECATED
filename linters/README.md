# Linters

## JSCS

Configuration of JSCS is via presets ( see http://jscs.info/overview#preset ), e.g. based off Google JavaScript style guides. 
This buik of the JSCS configuration file is then just selecting the desired preset and providing any overrides as necessary - i.e. it wont have much in it.
Note - as the presents are baked into JSCS, simply updating JSCS updates the presets and the associated linter rules. I.e there is no need to manually reconcile linter rules against the reference set.

## ESLint

Configuration managed by the eslint-config-defaults npm package ( https://www.npmjs.com/package/eslint-config-defaults ). This provides a setup of well known presets that can be selected via the eslint configuration file.

ESLint supports framework integration with e.g. React and Angular. Each integration is install as a npm package  (eslint-plugin-**) and configurated in the eslint configuration file within the packages section.

## JSHint

I've moved away from JSHint to ESLint for its ES2015+ support. In addition, ESLint configuration can be managed via the eslint-config-defaults package which allows for off-the-shelf configuration. 
