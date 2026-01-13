
Annesque email is an email client and a customer relationship management (CRM) suite. It is built on the annesque framework, which is a collection of ruby-on-rails engines, react apps, and certain other components.

The email client allows advanced functionality for a sophisticated email user. Filters, reminders, templates, as well as an AI capability.

The suite integrates with gmail, allowing you to check your mailbox less, and receive less spam. Check out our tutorials and common use cases.

Since email data is very sensitive, we recommend users to setup their instances of annesque crm on-premises, on their own hardware. This allows you to fully control your data, and not give it away to any provider. Having said that, Wasya Co offers ruby hosting for our apps. We can host the Annesque suite for you, and take care of all configuration requirements. This option is especially appropriate for users who anticipate filing feature requests. We will develop features according to your specification, and deploy them on your instance.

You can rent a cloud-hosted instance of annesque suite with our hosting plan - we offer production-grade deployments starting at $35/mo. _TODO click here.

Q&A:
- another email client?!
  That's right! Ours came out of necessity, and grew. We are proud of it.
- list of features
- how's security handled?
- you said, part of a larger software suite?


= Annesque setup =

== Production-grade setup ==

The production-grade setup is encapsulated in docker and allows the user to deploy the application with very few commands. The majority of the steps are configurations for external services. First, clone the repo:

git clone ...

Then, run the setup script:

cd <root> ; ./scripts/setup



== Development-grade setup ==

The development-grade setup is suitable for individuals who expect to contribute to the development of the application. It is a more complex setup than the production version.

