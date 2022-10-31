# iOS App Architecture

<!-- TOC -->
* [iOS App Architecture](#ios-app-architecture)
  * [Motivation](#motivation)
  * [App Architecture](#app-architecture)
  * [Sample Application](#sample-application)
<!-- TOC -->

## Motivation

Ideally, we would want to build something very scalable yet very concise, easy to understand, and
simple to implement.

## App Architecture

We are following the App Architecture suggested bt Google.

Learn App Architecture from Android Developers website.

- [Guide to app architecture ](https://developer.android.com/topic/architecture)
- [Architecture - MAD Skills](https://www.youtube.com/playlist?list=PLWz5rJ2EKKc8GZWCbUm3tBXKeqIi3rcVX)

<img height="250px" src="./pics/mad-arch-overview.png"/>

## Sample Application

We have build the sample application to demonstrate the App Architecture.

Kindly go through the code to better understand the App Architecture.

<img height="500px" src="./pics/Sample_App_Screenshot.png"/>

**API**

We will be using [Reqres](https://reqres.in/) to fetch the Users and display it in UI.

https://reqres.in/api/users?page=1

**Response**

```
{
  "page": 1,
  "per_page": 6,
  "total": 12,
  "total_pages": 2,
  "data": [
    {
      "id": 1,
      "email": "george.bluth@reqres.in",
      "first_name": "George",
      "last_name": "Bluth",
      "avatar": "https://reqres.in/img/faces/1-image.jpg"
    },
    {
      "id": 2,
      "email": "janet.weaver@reqres.in",
      "first_name": "Janet",
      "last_name": "Weaver",
      "avatar": "https://reqres.in/img/faces/2-image.jpg"
    }
  ],
  "support": {
    "url": "https://reqres.in/#support-heading",
    "text": "To keep ReqRes free, contributions towards server costs are appreciated!"
  }
}
```