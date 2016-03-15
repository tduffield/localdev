# Delivery Local Development Populator

This repo is intended to be used to easily create an organization with test
projects in your local development environment. 

1. Ensure an enterprise named `cd` is created.

        delivery/infra $ make create_enterprise_cd

2. Ensure your user added to the `cd` enterprise.

        delivery/infra $ make add_self_to_cd

3. Run `./setup.sh`

        localdev $ ./setup.sh
