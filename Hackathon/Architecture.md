## Sunbird Architecture
### Overview
Sunbird is an open source learning project aimed to build effective learning solutions and create diverse learning opportunities to exponentially impact mass learning.

The architecture is:

**Open-source and customizable:** Sunbird uses the open platform to empower individuals, where even failures contribute towards augmenting the solution. Being open-source, it can be customized to tailor to individual needs.
Cloud hosted: Sunbird is web-based, thus can be accessed from anywhere. With its feature rich mobile app and cross-browser compatibility, it provides seamless connectivity to content.
**Robust, secure, private:** Sunbird commits to safeguarding data security and user privacy, with high standards set in security to protect against any unauthorized access, data loss and misuse. Sunbird can be easily deployed on a private secure cloud or server for complete control.
Scalable: Sunbird supports from a few users to millions of users, thus supporting the needs of any type of organizations. It uses flexible frameworks like Apache Cassandra, Elasticsearch, Play Framework, Akka, Angular, Node.js & Android. These state of art technologies enable the utmost scalability and portability.
Extensible: It allows the introduction of new, innovative and customized components which can be easily plugged in. This flexibility and Openness in the platform allows Sunbird to inculcate the change when and where required.
Modular: Sunbird architecture is modular in nature , which provides isolation for developers and allows developing rapid development of many components independent of one another.It’s modular set up and interoperable design allows developers to create plugins and integrate external applications to achieve specific functionality
Flexible: Sunbird follows a layered architecture. It has a mix of service-oriented architecture and micro service pattern which makes it flexible to undergo changes with ease.
Offline-enabled: It is the offline availability that makes Sunbird standout of the rest, wherein not only content can be played and seen offline but the learning media can be downloaded without incurring further costs.
Multilingual: Access extensive Sunbird content and user forums in multiple languages,free content and courses shared by Sunbird users across the world.
Support: Sunbird is well-supported by an active community, and a team of dedicated full-time developers.It is driven by open collaboration.
The Sunbird software stack is an open-source web and mobile based learning platform which comes with batteries included. This document gives a 10,000 ft overview of the architecture to help new developers get a sense of the components without getting into too many details which muddle understanding.

Sunbird is built using the latest set of technologies which include Cassandra, Node.js and Elasticsearch among others. The software stack is designed with scale in mind from the start and can easily be deployed to cloud environments in Docker containers. The following sections describe the major components of the Sunbird architecture in more detail.

Sunbird employs a modern micro-service based architecture. Applications and components access a common set of [well-documented, public APIs](/link-to-api-documentation). In addition to its core components, Sunbird leverages a powerful set of content and analytics infrastructure from [EkStep](https://www.ekstep.org).

## Key Components
The essential components from which Sunbird derives its power are its content creation and distribution applications. Sunbird also incorporates a robust standards-based user registry to manage users and organisations and enables powerful community building tools.

### Web Application [Rayulu]

### Learning Management System (LMS) [Rayulu]

### Content Authoring

### Registry
The Sunbird registry records information about users of the system and organisations. It also provides the framework to manage user membership in organisations and their roles within the organisation. The registry is built using open API standards and open schemas such as [schema.org](https://schema.org/) and [JSON-LD](https://www.w3.org/TR/json-ld/). This makes the registry an open and extensible framework for any learner or organisation's profile.

### Communities
Coming soon!

#### Activity Streams
#### Forums and discussions
#### Tools
e.g.: Calendar, Announcements, Notifications

### Mobile Application

### Search

### Infrastructure
Sunbird makes the most of a powerful set of infrastructure tools to provide essential functions.

#### YouTube for Videos
Sunbird builds on top of YouTube as a repository and source of video based learning content. Publishing YouTube videos to Sunbird is as easy as providing a URL to the content.

#### Content Indexing
Content added to Sunbird needs to be indexed before it can be discovered. Sunbird uses EkStep's open content indexing APIs to provide an out-of-the-box content indexing experience.

#### Content Publishing
Before content is published into the Sunbird content repositories it must go through quality checks, packaging for offline access and content analysis. Sunbird uses EkStep's open content publishing APIs to provide secure and reliable content publishing functionality.

#### Telemetry and Analytics
Telemetry is the core that allows introspection into the operation of the learning platform. The telemetry collected by various elements of the application are routed into logging and analysis infrastructure via [telemetry APIs](/api/telemetry). The data collected conforms to the [API Specification](/api/telemetry/spec).

### Bits & Bytes
#### Tools
#### Testing
#### Monitoring
