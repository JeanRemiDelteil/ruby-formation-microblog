Feature: Article
  In order to manage articles
  As a big manager
  I want to use the Articles API

  Scenario: Get All articles
    Given I query the index actions
    Then I should see all articles

  Scenario: Create a new article
    Given I query the create actions
    Then I should get a new article created in the Database
