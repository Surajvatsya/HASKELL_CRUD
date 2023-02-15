{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-orphans #-}

module Domain.Types.User where

import Data.Aeson (FromJSON, parseJSON, withObject)
import Data.Aeson.Types
import Storage.Types.User

instance ToJSON User where
  toJSON user =
    object
      [ "name" .= userName user,
        "age" .= userAge user,
        "email" .= userEmail user
      ]

instance FromJSON User where
  parseJSON = withObject "User" parseUser

parseUser :: Object -> Parser User
parseUser o = do
  uName <- o .: "name"
  uEmail <- o .: "email"
  uAge <- o .: "age"

  return
    User
      { userName = uName,
        userEmail = uEmail,
        userAge = uAge
      }

-- defines a type class instance for the "User" type to convert it to JSON (JavaScript Object Notation) data format.

-- It uses the toJSON function from the ToJSON type class to convert a User value to a JSON value. The conversion is done using the object function which takes a list of key-value pairs, represented as "key" .= value. The keys in this example are "name", "age", and "email". The values are obtained by using the userName, userAge, and userEmail functions respectively on the User value being converted.

-- The first line defines a type class instance of "FromJSON User" which is used to parse a JSON object into a value of type User.
-- The second line defines the function "parseUser" which takes an "Object" (i.e. a JSON object) and returns a value of type "Parser User".
-- The function "parseUser" uses the ".:" operator from Aeson library to extract values from the JSON object for each field in the User data type (name, email, age).
-- The function then returns a value of type User, with the fields populated with the extracted values.
