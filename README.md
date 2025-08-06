# Blog API

A RESTful API for managing blog articles and tags built with Ruby on Rails.

## Features

- **Articles Management**: Create, read, update, and delete blog articles
- **Tags System**: Organize articles with tags
- **Article-Tag Associations**: Many-to-many relationship between articles and tags
- **Filtering**: Filter articles by tags
- **UUID Primary Keys**: Uses UUIDs for better scalability and security
- **Slug-based URLs**: SEO-friendly URLs using article slugs

## Tech Stack

- **Ruby**: 3.2.0
- **Rails**: 8.0+
- **Database**: PostgreSQL (with UUID support)
- **Testing**: RSpec (optional)

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Eccb7/blog-api.git
   cd blog-api
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Database setup**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the server**
   ```bash
   rails server
   ```

The API will be available at `http://localhost:3000`

## API Endpoints

### Articles

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/articles` | Get all articles |
| GET | `/articles/:slug` | Get specific article by slug |
| POST | `/articles` | Create new article |
| PUT/PATCH | `/articles/:slug` | Update article |
| DELETE | `/articles/:slug` | Delete article |
| GET | `/articles/filter?tag=:tag_name` | Filter articles by tag |

### Tags

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/tags` | Get all tags |
| POST | `/tags` | Create new tag |

## Request/Response Examples

### Get All Articles
```bash
curl -H "Accept: application/json" http://localhost:3000/articles
```

### Get Article by Slug
```bash
curl -H "Accept: application/json" http://localhost:3000/articles/your-article-slug
```

### Create Article
```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "article": {
      "title": "My New Article",
      "content": "Article content here...",
      "published_at": "2025-08-06T10:00:00Z"
    }
  }' \
  http://localhost:3000/articles
```

### Filter Articles by Tag
```bash
curl -H "Accept: application/json" http://localhost:3000/articles/filter?tag=ruby
```

### Get All Tags
```bash
curl -H "Accept: application/json" http://localhost:3000/tags
```

## Data Models

### Article
- `id` (UUID, Primary Key)
- `title` (String, Required, Unique)
- `slug` (String, Auto-generated from title)
- `content` (Text)
- `published_at` (DateTime)
- `created_at` (DateTime)
- `updated_at` (DateTime)

### Tag
- `id` (UUID, Primary Key)
- `name` (String, Required, Unique)
- `count` (Integer, Default: 0)
- `created_at` (DateTime)
- `updated_at` (DateTime)

### ArticleTag (Join Table)
- `id` (UUID, Primary Key)
- `article_id` (UUID, Foreign Key)
- `tag_id` (UUID, Foreign Key)
- `created_at` (DateTime)
- `updated_at` (DateTime)

## Database Schema

The API uses a many-to-many relationship between Articles and Tags through the ArticleTag join table:

```
Articles ←→ ArticleTags ←→ Tags
```

## Seeding Data

The project includes sample data for development:

```bash
rails db:seed
```

This creates:
- 10 sample tags
- 50 sample articles
- Random associations between articles and tags

## Development

### Running Tests
```bash
# If RSpec is configured
rspec
```

### Rails Console
```bash
rails console
```

### Check Routes
```bash
rails routes
```

### Database Console
```bash
rails dbconsole
```

## Error Handling

The API returns appropriate HTTP status codes:

- `200` - Success
- `201` - Created
- `404` - Not Found
- `422` - Unprocessable Entity (validation errors)
- `500` - Internal Server Error

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is open source and available under the [MIT License](LICENSE).
