# Wine Cellar Application

Welcome to the Wine Cellar Application! This application allows you to manage and search for various types of wines.

## Installation

### Prerequisites

- Ruby version 3.2.2
- Rails version 7.1.1
- Elasticsearch

### Getting Started

1. Clone the repository:

   ```bash
   $ git clone git@github.com:Kazdan1994/test-technique-ilek.git
   ```

2. Install dependencies:

   ```bash
   $ bundle install
   ```

3. Set up the database:

   ```bash
   $ rails db:create
   $ rails db:migrate
   ```

4. (Optional) Seed the database:

   ```bash
   $ rails db:seed
   ```

5. Start the elasticsearch docker

   ```bash
    $ docker run -d \
    --name elasticsearch-rails-searchapp \
    --publish 9200:9200 \
    --env "discovery.type=single-node" \
    --env "cluster.name=elasticsearch-rails" \
    --env "cluster.routing.allocation.disk.threshold_enabled=false" \
    --rm \
    docker.elastic.co/elasticsearch/elasticsearch:7.6.0
   ```

6. Enter in the rails console

   ```bash
    $ rails c
   ```

7. Enter in the following commands to create wine index and import wines in elasticsearch

   ```bash
    $ Wine.__elasticsearch__.create_index!(force: true)
    $ Wine.import(force: true)
   ```

8. Start the server and compile assets:

   ```bash
   $ ./bin/dev
   ```

9. Access the application in your browser at `http://localhost:3000`.

## Usage

- The application allows you to view a list of available wines.
- You can search for wines using the search bar.
- Clicking on a wine will display more details about that particular wine.

## Testing

To run the tests, use the following command:

```bash
rails test
```

## Contributing

If you wish to contribute to this project, please follow the guidelines in the CONTRIBUTING.md file.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

We would like to thank the developers and contributors of the following technologies and libraries used in this project:

- Ruby on Rails
- Elasticsearch
- Pagy
