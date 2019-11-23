# GroceryApp
A simple and elegant looking Grocery delivery iOS app for day to day groceries.

## What this app is about
* This app lets you buy fruits, vegetables, meat and dairy.
* The app also includes login/register functionality with Firebase backend and Alamofire HTTP calls.
* User can add items to cart, make payment through Stripe.

## Design motivation
* [Michele Leone](https://dribbble.com/shots/7097851-MyGrocery)


## App logo
![Logo](https://github.com/utsavDave97/GroceryApp/blob/master/GroceryApp/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60%403x.png)

## Libraries Used
* [Alamofire](https://github.com/Alamofire/Alamofire) - Library to make API calls
* [Stripe SDK](https://stripe.com/en-ca) - Library to get user's payment
* [Firebase](https://firebase.google.com/) - Library to store user's details

## Authors
* **Utsav Dave**

## Screenshots
* As soon as the app launches Onboarding Screen loads up. This screen would introduce the app to the user and what the app is about.

![OnboardingScreen](https://github.com/utsavDave97/GroceryApp/blob/master/screenshots/onboarding.gif)

* The below screen is Register Screen where user has to enter name, email and password which should have one uppercase and atleast 8 characters long. The information gets stored inside **Firebase** backend.

![RegisterScreen](https://github.com/utsavDave97/GroceryApp/blob/master/screenshots/register.gif)

* The below screen is Categories Screen where user has various options to choose between fruits, vegetables, meat and dairy. After user selects one of the category it shows a list of products available inside that particular category with high-res image and price. Also, detail view of each product lets you add product to your cart.

![CategoriesScreen](https://github.com/utsavDave97/GroceryApp/blob/master/screenshots/categories.gif)

* The below screen is Cart Screen where user when taps on Add To Cart button, the product gets included inside cart. Here, the cart is a singleton class inside the app. When, user proceeds to enter payment information the app shows **Stripe UIViewController** where user can add card information and the payment is stored.

```diff
-here one thing to notice is that, the app being strictly focused on iOS side the payment doesnt go through for that you have to have a proper backend service with PHP or Ruby.

-Due to this fact, it only stores card information inside Stripe.
```

![CartScreen](https://github.com/utsavDave97/GroceryApp/blob/master/screenshots/cart.gif)

* The below screen is Profile Screen where user can update password or update email. Also, user can delete the account.

![ProfileScreen](https://github.com/utsavDave97/GroceryApp/blob/master/screenshots/profile.gif)

* The below screen is Settings Screen where user can contact, mail or visit the developer.

![SettingsScreen](https://github.com/utsavDave97/GroceryApp/blob/master/screenshots/settings.png)
