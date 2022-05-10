# Using TypeScript in Fiori elements V4 App

## Run Setup

- Checkout branch 'typescript'
- npm install
- npm run start:ts

The start script 'start:ts' executes multiple npm scripts in parallel:

- a babel script in watch mode taking care of live ts compilation including source map generation (for debugging purposes) and copying of folder structure content from 'app/managetravel/src' -> 'app/managetravel/webapp'  
- a cds watch script including start of the application via --open parameter

Setup based on [UI5 TypeScript Tutorial](https://github.com/SAP-samples/ui5-typescript-tutorial).

## Further Links

[UI5 Typescript helloworld](https://github.com/SAP-samples/ui5-typescript-helloworld)
[UI5 & TypeScript](https://sap.github.io/ui5-typescript/#how-to-convert-an-existing-ui5-app-to-typescript)
[Configure Babel](https://babeljs.io/docs/en/configuration)