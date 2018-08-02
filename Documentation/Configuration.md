#  Configuration

Snowonder allows you to provide your custom configuration. For example, you can change sorting rules, formatting operations, or even define detection for some other programming languages that are not supported out of the box. Remember that you can always submit pull request to update default configuration.

Configuration document is represented as JSON. Default configuration:

```javascript
{
   "groups":[
      [
         {
            "title":"Framework",
            "sortingRulesChain":[
               {
                  "alphabeticallyIsAscending":true
               }
            ],
            "declarationPattern":"^\\s*(import) +.*."
         },
         {
            "title":"Testable",
            "sortingRulesChain":[
               {
                  "alphabeticallyIsAscending":true
               }
            ],
            "declarationPattern":"^\\s*(@testable \\s*import) +.*."
         }
      ],
      [
         {
            "title":"Module",
            "sortingRulesChain":[
               {
                  "alphabeticallyIsAscending":true
               }
            ],
            "declarationPattern":"^\\s*(@import) +.*."
         },
         {
            "title":"Global",
            "sortingRulesChain":[
               {
                  "alphabeticallyIsAscending":true
               }
            ],
            "declarationPattern":"^\\s*(#import) \\s*<.*>.*"
         },
         {
            "title":"Global Include",
            "sortingRulesChain":[
               {
                  "alphabeticallyIsAscending":true
               }
            ],
            "declarationPattern":"^\\s*(#include) \\s*<.*>.*"
         },
         {
            "title":"Local",
            "sortingRulesChain":[
               {
                  "alphabeticallyIsAscending":true
               }
            ],
            "declarationPattern":"^\\s*(#import) \\s*\".*\".*"
         },
         {
            "title":"Local Include",
            "sortingRulesChain":[
               {
                  "alphabeticallyIsAscending":true
               }
            ],
            "declarationPattern":"^\\s*(#include) \\s*\".*\".*"
         }
      ]
   ],
   "operations":[
      "trimWhitespaces",
      "uniqueDeclarations",
      "sortDeclarations",
      "separateCategories"
   ]
}
```

This document consists of two main sections:
* Groups
* Operations

## Groups

First of all, let's review `groups`, an array of import groups. Each import group is represented as an array of import categories. You may usually want to think that import group is a set of rules, that describes possible import categories. Snowonder will try to match formatting file to one of these groups and that use it's rules. The ordering of both groups and import categories in the array is important for further formatting:
* The groups ordering defines which group will be matched. Groups at the top of the list are more important. *There are plans to make this behavior configurable! Drafted detection rules: "First Matched, Count Important". Check newer versions of Snowonder* 😁
* The import categories ordering defines the ordering of categories after separation.

### Import Category

As mentioned before import category is a part of import group, and is an object which has the following fields:

`title`
Name of import category. Name **must** be unique in scope of one group.

`sortingRulesChain`
Array of sorting rules which are chained. Available rules:
* `"alphabeticallyIsAscending":true` sorts declarations in category alphabetically and where value defines `isAscending` flag
* `"lengthIsAscending":true` sorts declarations in category using string length where value defines `isAscending` flag

`declarationPattern`
Regular expression that defines this import category.

## Operations

The array of operations that will be applied to detected import declarations. Ordering is important.

`trimWhitespaces`
Trims whitespaces in import declarations.

`uniqueDeclarations`
Removes duplicated import declarations.

`sortDeclarations`
Enables sorting in scope of category.

`separateCategories`
Separates categories with one empty line. It's better to use this as final operation.

