# Changelog

## 1.0.13
* 1 minor enhancement:
  * Add more custom error classes for regular HTTP errors

## 1.0.12
* 1 minor enhancement:
  * Custom error class for already watched vehicle

## 1.0.11
* 1 minor enhancement:
  * Add Findable module to Inspection resource

## 1.0.10
* 2 minor enhancements:
  * Add support for ErrorCode
  * Add support for WatchedVehicle

## 1.0.9
* 1 minor enhancement:
  * page attribute reader in ApiResponse

## 1.0.8
* 3 minor enhancements:
  * LeasingPeriod resource
  * Support for search in Brand, Model, Variant, and Version
  * Normalize search

## 1.0.7
* 3 minor enhancements:
  * Remove Faraday dependency and use Net::HTTP instead
  * Remove ActiveSupport dependency
  * Support search in InspectionTestCenter

## 1.0.6
* 1 minor enhancement:
  * total_count attribute reader in ApiResponse

## 1.0.5
* 1 minor enhancement:
  * Make has_more and total_pages dynamic

## 1.0.4
* 1 minor enhancement:
  * Escape registration using CGI (to support ÆØÅ)

## 1.0.3
* 1 minor enhancement:
  * Support expand
  * Add Vehicle#find_by_vin

## 1.0.2
* 1 minor enhancement:
  * Introduce after_request callback

## 1.0.1
* 1 minor enhancement:
  * Fix error that would occur when configuring the gem

## 1.0.0
* 1 major enhancement:
  * Initial release
