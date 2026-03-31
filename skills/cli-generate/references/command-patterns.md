# Command Patterns — Mapping Endpoints to CLI Commands

## MCP Server → CLI Commands

| MCP Concept | CLI Equivalent |
|-------------|---------------|
| `server.tool("get_mrr", schema, handler)` | `new Command('mrr').action(...)` |
| `z.string().describe("User email")` | `.option('--email <value>', 'User email')` |
| `z.number().optional()` | `.option('--count [value]', '...', parseFloat)` |
| `z.boolean()` | `.option('--verbose', '...')` |
| `z.enum(["a","b","c"])` | `.option('--type <value>', '...').choices(["a","b","c"])` |
| `z.array(z.string())` | `.option('--tags <items>', '...', (v) => v.split(','))` |
| `z.object({...})` | `.option('--data <json>', '...', JSON.parse)` |

### Command Naming
- `get_mrr` → `mrr` (strip `get_` prefix)
- `get_customer_count` → `customers`
- `send_email` → `send-email` (kebab-case)

## OpenAPI Spec → CLI Commands

| Method | Path | Command Name |
|--------|------|-------------|
| GET | /users | `list-users` |
| GET | /users/{id} | `get-user` |
| POST | /users | `create-user` |
| PUT | /users/{id} | `update-user` |
| DELETE | /users/{id} | `delete-user` |

If `operationId` exists, prefer it (kebab-cased).

## Next.js Routes → CLI Commands

```
app/api/users/route.ts          → GET: list-users, POST: create-user
app/api/users/[id]/route.ts     → GET: get-user, PUT: update-user, DELETE: delete-user
app/api/health/route.ts         → SKIP (health check)
```

## Express/Fastify → CLI Commands

Grep for route definitions, extract method + path + handler. Same naming convention.

## Human Output Patterns

### Single value
```
$392.00
```

### Key-value pairs
```
MRR:          $392.00
ARR:        $4,704.00
Customers:        18
```

### Tables (use hand-rolled renderTable)
```
Name              Email               Plan        MRR
---------------------------------------------------------
Jane Smith        jane@acme.co        Pro         $29.00
```
