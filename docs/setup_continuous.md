
= Production Setup for Continuous Deployment =

Back in the old days before docker, continuous deployment of ruby on rails applications was done with capistrano. You'd setup ruby (via rbenv) on your server, wire in capistrano, and issue `cap production deploy` to deploy the newest version of the codebase to production.

We will not do that here. Instead, we'll use Docker plain and simple, and issue `git pull` over `ssh` to update the codebase, paying special attention that configuration is not overwritten.

This is pretty much the same as a production install for non-developers.

