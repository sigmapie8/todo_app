# TODO App With Inherited Widget

A simple todo app which uses inherited widget as a state management solution. I went through the Inherited Widget [codelab](https://github.com/sigmapie8/flutter_codelabs#how-to-manage-application-states-using-inherited-widgets--workshop-inherited-widget-workshop) for flutter and wanted to create an app to understand the material on my own.

## Screenshots
![todo app result](./readme_resources/todo_app_inherited_widget.gif | width=100)

## Architecture

I tied to follow Domain Driven Design (DDD). The app is divided into the following layers:

1. **Presentation:** Contains all the UI code.
2. **Application:** Contains all the driver code that calls the services/business logic. Inherited Widget stays in this layer.
3. **Domain:** Contains all the service blueprints (abstract classes), models, entities and policies.
4. **Data:** Contains the implementations for abstract classes in domain. Interacts with the outside world so all the API implementations are usually kept here.


