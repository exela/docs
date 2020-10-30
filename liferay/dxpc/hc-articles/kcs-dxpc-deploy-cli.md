# Building and Deploying using the DXP Cloud CLI

The CI service (Jenkins) also triggers when `lcp deploy` is invoked via the command line.  If we have a DXPC code repository checked out locally, we can build the environment using Gradle tasks and deploying via use of `lcp` commands.

1. At the root level of the repository, run `blade gw disLiferayCloud` - this prepares the `LCP.json` for deployment.  It creates a `build/` directory containing the `LCP.json` files which are used to deploy the DXPC services.

2. Once built, navigate to `/build/lcp/` and run `lcp deploy` to deploy all services of the specified environment.  Alternatively, we can also deploy a single service, by going into a service folder such as `/build/lcp/liferay` and running `lcp deploy` at the same level of the service's `LCP.json` file.

3. Running `lcp deploy` will prompt the CLI to ask which environment to deploy to.  Selecting a number will begin deployment of the services to the environment.

4. The deployment can take some time and even fail.  Follow the deployments in the **Logs** page of the DXP Cloud console to track the process.  For verbose logs, use the drop-down and select a specific service.

>**NOTE:** In the deployment logs, the `ci` service may say `Deployment skipped`.  This is due to the `ci` service `LCP.json` file indicating deployment ONLY to the `ci` environment.  So if we deploy to any environment outside of `ci` such as `dev` or `uat` - this results in a skipped deployment.