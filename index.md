---
title       : Height Prediction Model
subtitle    : A shiny app
author      : Fille8557
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : Default      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides


--- 

## Height prediction model shiny app

My shiny app (https://fille8557.shinyapps.io/shinystuff) attemps to answer the question: Can I guess your height based only on your parents' heights?

This app will make predictions based on: 

* Units: centimeters or inches
* Sex: male or female

As well as give a 90% prediction interval, since not everyone fits perfectly into the model.

--- 

## Data used

I used the historical GaltonFamilies dataset from the UsingR package.

Unlike the simpler Galton dataset, GaltonFamilies gives the gender of the child. 

This allows my prediction to have an extra element.

--- 

## Calculations done on data - linear model

In order to predict heights based on sex, I created a simple linear model with the added element of subsetting by gender.

For example, for males:


```r
lm(childHeight~midparentHeight, 
   gender=="male", data=GaltonFamilies)
```

But first, to obtain the parents' mid height, I had to take the input, multiply the mother's height by 1.08, add it to the father's height, and divide it by two.

So for a mother with a height of 65 inches and a father with a height of 68 inches, the calculation would be:


```r
((65*1.08)+68)/2
```

```
## [1] 69.1
```

This is the number used in the model to make the height prediction.

---


## Calculations done on data - height units

In order to predict using centimeters, the mid height, when given in centimeters, was multipled by 0.393701, to be used in the model which was based on measurements in inches.

So for example, if a mother's height is 165 centimeters and a father's height is 168 centimeters, the mid parents height in inches used in the model is:


```r
(((165*1.08)+168)/2)*0.393701
```

```
## [1] 68.14964
```

Then, once the model gave the result in inches, it was multipled by 2.54 to return the result in centimeters for the user.


```r
68.15 * 2.54
```

```
## [1] 173.101
```

This simple multiplication allows the app to be used by people using either unit of measurement.

