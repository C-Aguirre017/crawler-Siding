# crawler-Siding for Employability Workshop and Design Career
  
  This is a simple crawler application that runs every day using heroku scheduller to see if there is any spot available in the Employability Workshop and Design Career.

## Deployment
  Right now is deploy in heroku:    https://tallerdeempleabilidad.herokuapp.com/

## Code Example
  Ex: `rails s && rake crawler:start`

## Installation

 Just clone this repository and add two Environmental variables in your computer.

  Username | Password
  --- | ---
  *SECRET_USER* | `your_username`
  *SECRET_PASSWORD* | `your_password`
  *USER_EMAIL* | `email`
  *PASS_EMAIL* | `email_password`
