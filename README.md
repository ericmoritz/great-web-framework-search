## Goals:

1. No global, thread-unsafe state (i.e. django.conf.settings)
2. Concurrent (easy to do concurrent work within a request)
3. Type safety (no more runtime type errors please)
4. Easy to process JSON and XML
5. Composition (system is built from a collection of components by
   many developers)
6. git-flow friendly (easy to switch between feature branches)
7. self contained releases (easy deployment to a cluster of machines)
8. "Pure core"; business logic shouldn't know it is in a web request
   or its data is from a database (easier to test)
9. The ability to theme and friendly to front-end developers
11. private packaging (i.e. private pypi, private npm, etc)

### No global, thread-unsafe state

Each request must have a private copy of the configuration state which
cannot affect other request.

If the configuration state changes, it must not be seen in current
running requests.  This is basically the
["Isolation"](http://en.wikipedia.org/wiki/Isolation_%28database_systems%29)
in ACID.

### Concurrency

It must be easy to concurrently make requests to external web services, databases, etc.

The framework must support long running requests such as WebSockets,
Comet, etc.

### Type-safety

Large projects need type-safety.  Careless changes in a dynamic system
can wreak system integration. Unit Test are not enough to solve errors
introduced by refactoring.

The framework must provide mechanisms that prevent runtime type
errors.  Runtime type errors are the most common errors in web
applications.

### Easy to process JSON and XML

JSON is becoming the de-facto standard for Web Services.  It must not
be cumbersome to process it.

XML is also a common format, it should not be cumbersome to process
either

### Composition

Large project are composed of many components made by many developers.
These projects need a standard composition framework with clearly
defined boundaries.  Django apps are a step in the right direction but
are too ad-hoc.  The framework needs to enable self contained web
components which are bundled with their resources and configurable.

### git-flow friendly

It should not be cumbersome to switch between feature branches using
git-flow

### Self contained releases

Projects in the framework need to be isolated.  Dependencies of one
project must not cause conflicts with another.

Project must also need to be built on one machine and be able to
copied to a cluster of homogeneous machines 

### Pure core

Projects built on in this framework must not hinder the ability to
have a pure-core.  What this means is that the business logic of an
application must be able to be written purely without reliance on a DB
or Web Request.

### Ability to theme and friendly to front-end developers

The ability to theme means that the same project can run multiple
themed sites; ideally in the same process.

Friendly to front-end developers means automatic recompilation and a
template language that looks like HTML/JS/CSS.  The front-end
developers should not have to learn the server-side language to style
the site.

### Private packaging

The building of the project should be able to use the language's
native packaging tools with private code.
