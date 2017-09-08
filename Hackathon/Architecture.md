## Architectural Design

With a multi-tenant and robust framework. Sunbird Architectural design is resilient, flexible and agile. The Service Oriented & Microservice patterns enhances the structure and functionality of Sunbird. Sunbird employs a modern micro-service based architectural design. Applications and components access a common set of [well-documented, public APIs] (/link-to-api-documentation). In addition to its core components, Sunbird leverages a powerful set of content and analytics infrastructure from [EkStep](https://www.ekstep.org). In addition, the design patterns provide services which are structured in such a manner that it maximizes on abstraction and security, enables portability, augments testing, provides seamless maintainability, gives better scalability, provides higher availability, Interoperability and rationalization.

>**Diagram under review** 


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
