# Detection Matrix — Project Type Identification

## Two-Tier Architecture

**Tier 1 (fast path):** Pattern-based detection for common frameworks. Mechanical extraction. Covers ~80% of real usage.

**Tier 2 (LLM-native):** Claude reads the actual source code and extracts the API surface. Works for ANY language or framework.

Both tiers produce the same intermediate representation:
```
Endpoint: { name, method, path, params[], auth, description }
```

## Detection Order

### Step 0: Identify the Language

| File | Language/Ecosystem |
|------|-------------------|
| `package.json` | JavaScript/TypeScript → check Tier 1 frameworks |
| `go.mod` | Go → Tier 2 |
| `requirements.txt` / `pyproject.toml` | Python → Tier 2 |
| `Gemfile` | Ruby → Tier 2 |
| `Cargo.toml` | Rust → Tier 2 |
| `pom.xml` / `build.gradle` | Java/Kotlin → Tier 2 |
| `*.proto` files | gRPC → Tier 2 |
| `*.graphql` / `schema.graphql` | GraphQL → Tier 2 |
| `openapi.yaml` / `openapi.json` | OpenAPI → Tier 1 (any language) |

## Tier 1: Pattern-Based Detection (JS/TS + OpenAPI)

### 1. MCP Server
**Signals (any 2 = confirmed):**
- `@modelcontextprotocol/sdk` in dependencies
- `server.tool(` or `new McpServer(` in source
- `StdioServerTransport` or `SSEServerTransport`

**Extract:** Each `server.tool("name", schema, handler)` → command. Zod schema → CLI flags.

### 2. OpenAPI Spec
**Signals:** `openapi.yaml`, `openapi.json`, `swagger.yaml`, `swagger.json`

**Extract:** Each path + method with `operationId` → command. Path params → required flags. Query params → optional flags.

### 3. Next.js App Router
**Signals:** `app/` directory with `route.ts` files, `next` in dependencies

**Extract:** Each `app/**/route.ts` exported function → command.

### 4. Next.js Pages Router
**Signals:** `pages/api/` directory, `next` in dependencies

### 5. Express / Fastify
**Signals:** `express` or `fastify` in dependencies, `router.get(` patterns

## Tier 2: LLM-Native Analysis (Any Language)

When Tier 1 doesn't match, read the actual code:

1. Identify entry points from manifest files
2. Read routing/controller files
3. Extract endpoints with params, auth, descriptions

### Language Hints

| Language | Common Patterns |
|----------|----------------|
| **Python** | `@app.route()` (Flask), `@router.get()` (FastAPI), `urlpatterns` (Django) |
| **Go** | `http.HandleFunc()`, `r.GET()` (Gin), `e.GET()` (Echo) |
| **Ruby** | `resources :users` (Rails), `get '/'` (Sinatra) |
| **Rust** | `.route()` (Actix), `Router::new().route()` (Axum) |
| **Java/Kotlin** | `@GetMapping`, `@PostMapping` (Spring Boot) |
| **gRPC** | `service { rpc Method(Request) returns (Response) }` in `.proto` |
| **GraphQL** | `type Query { users: [User] }`, `type Mutation { ... }` |

Asking the user is the LAST resort, not the first.
