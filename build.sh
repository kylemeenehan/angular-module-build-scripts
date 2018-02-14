# Clean up previous distribution
rm -Rf dist
rm -Rf build

# Variable pointing to NGC
NGC="node node_modules/.bin/ngc"
ROLLUP="node node_modules/.bin/rollup"

MODULES=(
  "your"
  "modules"
  "here"
)


# Run Angular compiler
# $NGC -p tsconfig.bundle.json

for module in ${MODULES[@]}
do
  echo "compiling ${module}"
  $NGC -p ./src/app/your-components-module/${module}/tsconfig.json
done

# Flatten file structure
mv ./build/src/app/your-components-module/* ./build/
rm -Rf ./build/src


for module in ${MODULES[@]}
do

  echo "bundling ${module}"
  $ROLLUP build/${module}/${module}.js \
    --output.format es --name "${module}" \
    --output.file dist/${module}/${module}.umd.js

  echo "copying package.json for ${module}"
  cp ./src/app/your-components-module/${module}/package.json dist/${module}/package.json

  echo "syncing files for ${module}"
  rsync -a --exclude=*.js build/ dist

done

# Copy package.json
cp ./package.bundle.json dist/package.json
