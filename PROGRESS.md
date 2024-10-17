# Technical assignment for Apple

## Task

- Accept an address as input
- Retrieve forecast data for the given address. This should include, at minimum, the current temperature (Bonus points - Retrieve high/low and/or extended forecast)
- Display the requested forecast details to the user
- Cache the forecast details for 30 minutes for all subsequent requests by zip codes. Display indicator if result is pulled from cache.

## Solution

The app has been generated as

```
rails new . --name=apple_weather --database=postgresql -M --skip-action-mailbox --skip-action-text --skip-active-job --skip-active-storage --skip-action-cable --skip-hotwire --skip-jbuilder --skip-devcontainer --skip-ci
```

Parts:

- [weatherapi.com](https://www.weatherapi.com/) as provider
- httparty as API wrapper
- MongoDB for storage
- RSpec for tests
