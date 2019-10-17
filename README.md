# Job IO

## Team Members

|Name  |Github   |Email   |Photo   |
|---|---|---|---|
|Luca Matsumoto   |lucamatsumoto   |lucamatsumoto@gmail.com   |![alt text](https://github.com/scalableinternetservices/job-io/tree/master/teampics/luca.jpeg)   |
|Terrence Ho   |TerrenceHo   |terrenceho.books@gmail.com   |![alt text](https://github.com/scalableinternetservices/job-io/tree/master/teampics/terrence.jpg)  |
|Jayant Mehra   |JayantMehra   |jayantmehra1599@gmail.com   |![alt text](https://github.com/scalableinternetservices/job-io/tree/master/teampics/jayant.jpg)  |
|Ryan Miyahara  |rmiyahara   |rmiyahara144@gmail.com   |![alt text](https://github.com/scalableinternetservices/job-io/tree/master/teampics/ryan.jpg)   |

## Project Description

Job IO is a career fair easy job portal application for making career fairs manageable from both the company and candidate standpoint.

Users can submit resumes on their profile while companies can sign up for career fairs. When an applicant attends a career fair, they can submit their resume through a QR code. Our service will then automatically batch resumes to the respective companies.

## Section

We will be meeting during the 12pm section on Friday's. 

## Project Setup

We will be using Docker (>=19.03) to containerize our application and simplify our development process. You must have Docker and docker-compose on your system to run the following.

Create app inside docker container

`docker-compose run web rails new . --force --no-deps --database=postgresql`

Build docker image

`docker-compose build`

Create Postgres DB

`docker-compose run web rake db:create`

Start the app

`docker-compose up -d`

Kill the app

`docker-compose down`