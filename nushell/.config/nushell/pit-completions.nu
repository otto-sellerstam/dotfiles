# nushell completion for pit CLI
# Install: pit completions nushell | save -f ~/.config/nushell/pit-completions.nu
# Then add to ~/.config/nushell/config.nu: use ~/.config/nushell/pit-completions.nu *

def "nu-complete pit" [] {
  [
    { value: "api", description: "Backend API commands for CLI interactions" },
    { value: "artifactory", description: "Artifactory build job management" },
    { value: "build", description: "Build apps and services" },
    { value: "check", description: "Run code quality checks" },
    { value: "completions", description: "Generate shell completion scripts" },
    { value: "complexity", description: "Analyze code complexity" },
    { value: "customer-repository", description: "Manage customer repositories" },
    { value: "db", description: "Database operations (generate, push, migrate, studio, reset)" },
    { value: "dependencies", description: "Manage dependency versions and upgrades" },
    { value: "deploy", description: "Deploy operator commands for targets, status, and config" },
    { value: "dev", description: "Start development servers (apps, services)" },
    { value: "editor", description: "Manage editor workspaces" },
    { value: "evals", description: "Run LLM evaluations and comparisons" },
    { value: "infra", description: "Infrastructure operations (deploy, secrets)" },
    { value: "notifications", description: "Deployment notification commands" },
    { value: "packages", description: "Build and publish distribution packages" },
    { value: "pre", description: "Run pre-commit/pre-flight checks and tests" },
    { value: "scripts", description: "Utility scripts for development workflows" },
    { value: "serve", description: "Serve apps and services (production-like)" },
    { value: "setup", description: "Initialize development environment" },
    { value: "sync", description: "Sync files according to manifest fileSyncing rules" },
    { value: "templates", description: "List and retrieve codegen templates" },
    { value: "test", description: "Run tests (unit, integration, e2e)" },
    { value: "worker", description: "Interact with workflow worker sandbox pods" },
    { value: "workflow", description: "Workflow automation commands" },
    { value: "wtf", description: "Clean everything: remove node_modules, caches, reinstall, and run all checks" },
  ]
}

def "nu-complete pit api" [] {
  [
    { value: "workflow", description: "Workflow management API commands" },
    { value: "orgs", description: "Manage organizations" },
    { value: "users", description: "Manage users" },
    { value: "projects", description: "Manage projects" },
    { value: "config", description: "Manage API CLI configuration" },
    { value: "ui-preview", description: "Manage UI previews" },
    { value: "studio", description: "Studio sync commands" },
    { value: "upload", description: "Upload a file to an organization" },
    { value: "file-text", description: "Get extracted text from an uploaded file" },
  ]
}

def "nu-complete pit api workflow" [] {
  [
    { value: "job", description: "Manage workflow jobs" },
  ]
}

def "nu-complete pit api workflow job" [] {
  [
    { value: "list", description: "List workflow jobs from the backend" },
    { value: "cancel", description: "Cancel a workflow job" },
    { value: "steps", description: "List steps for a workflow job" },
    { value: "logs", description: "List logs for a workflow job" },
  ]
}

def "nu-complete pit api orgs" [] {
  [
    { value: "list", description: "List all organizations" },
    { value: "create", description: "Create a new organization" },
    { value: "update", description: "Update an organization" },
    { value: "members", description: "Manage organization members" },
    { value: "domains", description: "Manage auto-join email domains" },
  ]
}

def "nu-complete pit api orgs members" [] {
  [
    { value: "list", description: "List organization members" },
    { value: "add", description: "Add a member to an organization" },
    { value: "invite", description: "Invite a user to an organization" },
  ]
}

def "nu-complete pit api orgs domains" [] {
  [
    { value: "list", description: "List auto-join email domains for organizations" },
    { value: "add", description: "Add an auto-join email domain to an organization" },
    { value: "remove", description: "Remove an auto-join email domain" },
  ]
}

def "nu-complete pit api users" [] {
  [
    { value: "set-active-org", description: "Set a user's active organization" },
    { value: "list", description: "List all users" },
  ]
}

def "nu-complete pit api projects" [] {
  [
    { value: "list", description: "List projects in an organization" },
    { value: "create", description: "Create a new project in an organization" },
  ]
}

def "nu-complete pit api config" [] {
  [
    { value: "set-org", description: "Set the default organization ID" },
    { value: "get-org", description: "Get the current default organization ID" },
    { value: "set-user", description: "Set the default user ID for API operations" },
    { value: "get-user", description: "Get the current default user ID" },
    { value: "set-key", description: "Store a per-user API key for CLI authentication (optionally per environment)" },
    { value: "show-key", description: "Show stored API keys (masked)" },
  ]
}

def "nu-complete pit api ui-preview" [] {
  [
    { value: "push", description: "Build a frontend app, upload to GCP, and register as UI preview" },
    { value: "reset", description: "Reset stuck UI preview workflow jobs" },
  ]
}

def "nu-complete pit api studio" [] {
  [
    { value: "sync-pull", description: "Pull brief and app-structure documents from Pit Studio to local files" },
    { value: "sync-push", description: "Push local brief and app-structure documents to Pit Studio" },
  ]
}

def "nu-complete pit artifactory" [] {
  [
    { value: "status", description: "Show artifactory build status dashboard" },
    { value: "jobs", description: "List build jobs" },
    { value: "get", description: "Get build job details" },
    { value: "logs", description: "Get build pod logs" },
    { value: "images", description: "List recent images for a template" },
    { value: "build", description: "Trigger a build for a template and git ref" },
  ]
}

def "nu-complete pit build" [] {
  [
    { value: "all", description: "Build all apps and services" },
    { value: "app", description: "Build frontend applications" },
    { value: "service", description: "Build backend services" },
  ]
}

def "nu-complete pit check" [] {
  [
    { value: "all", description: "Run all checks" },
    { value: "markdown-links", description: "Check that all relative markdown links are valid" },
    { value: "manifests", description: "Check that code adheres to the architecture manifest rules" },
    { value: "routes-manifests", description: "Check that route manifests are in sync with routes entry packages" },
    { value: "empty-folders", description: "Check for empty folders in the workspace" },
    { value: "env", description: "Verify .env and .env.development are in sync with config packages" },
    { value: "lint", description: "Run oxlint check" },
    { value: "knip", description: "Run knip check for unused exports and dependencies" },
    { value: "lockfile", description: "Verify that pnpm-lock.yaml is up to date" },
    { value: "migration", description: "Verify that all schema changes have corresponding migrations" },
    { value: "format", description: "Run oxfmt check" },
    { value: "types", description: "Run TypeScript type checking" },
    { value: "unused-manifests", description: "Check for unused manifest types not referenced by any folder" },
  ]
}

def "nu-complete pit completions" [] {
  [
    { value: "bash", description: "" },
    { value: "zsh", description: "" },
    { value: "fish", description: "" },
    { value: "nushell", description: "" },
  ]
}

def "nu-complete pit complexity" [] {
  [
    { value: "analyze-files", description: "Analyze per-file code complexity using FTA" },
    { value: "analyze-packages", description: "Analyze code complexity grouped by package using FTA" },
  ]
}

def "nu-complete pit customer-repository" [] {
  [
    { value: "init", description: "Initialize a new customer repository at the given path" },
    { value: "validate", description: "Validate the customer repository template by running init, install, sync, and pre flight" },
  ]
}

def "nu-complete pit db" [] {
  [
    { value: "create-template", description: "Create a test template database with migrations applied" },
    { value: "generate", description: "Generate database migrations using drizzle-kit" },
    { value: "push", description: "Push schema changes to database using drizzle-kit" },
    { value: "migrate", description: "Run database migrations using drizzle-kit" },
    { value: "studio", description: "Launch Drizzle Studio web interface" },
    { value: "reset", description: "Drop and recreate the database" },
  ]
}

def "nu-complete pit dependencies" [] {
  [
    { value: "update-manifest", description: "Sync the dependency manifest with the pnpm catalog and latest versions" },
    { value: "upgrade", description: "Upgrade dependencies according to the manifest with type checking and rollback" },
  ]
}

def "nu-complete pit deploy" [] {
  [
    { value: "create", description: "Create a new PitDeploy service CRD" },
    { value: "destroy", description: "Destroy a PitDeploy service CRD and all its targets/config" },
    { value: "list", description: "List deploy targets" },
    { value: "get", description: "Get deploy target and current status for an environment" },
    { value: "set", description: "Set desired SHA for a service environment" },
    { value: "delete", description: "Delete deploy target and config for an environment" },
    { value: "history", description: "Show deploy event history for an environment" },
    { value: "audit", description: "Show audit log of all API mutations (config changes, deploys, rollbacks) for a service." },
    { value: "rollback", description: "Rollback deployment target to previous deployed event" },
    { value: "status", description: "Show deploy status overview (snapshot or live updates)" },
    { value: "config", description: "Manage deploy config for customer environments" },
    { value: "logs", description: "Read or stream logs for a deployment" },
  ]
}

def "nu-complete pit deploy config" [] {
  [
    { value: "get", description: "Get deploy config for a service environment" },
    { value: "set", description: "Set deploy config key(s) for a service environment. Use KEY VALUE positional args for a single key, or --file for bulk replace." },
    { value: "patch", description: "Patch deploy config keys for a service environment" },
    { value: "delete-key", description: "Delete a deploy config key" },
  ]
}

def "nu-complete pit dev" [] {
  [
    { value: "all", description: "Start frontend applications and backend services by name" },
    { value: "app", description: "Start frontend applications" },
    { value: "service", description: "Start backend services" },
  ]
}

def "nu-complete pit editor" [] {
  [
    { value: "open", description: "Discover and open Pit workspaces in the editor" },
    { value: "close", description: "Close editor sessions for Pit workspaces" },
  ]
}

def "nu-complete pit evals" [] {
  [
    { value: "run", description: "Run LLM evaluation tests (*.eval.ts files)" },
    { value: "comparison", description: "Run model comparison evaluation - produces YAML for blind A/B human grading" },
  ]
}

def "nu-complete pit infra" [] {
  [
    { value: "add-secret", description: "Create or update a local development secret in Secret Manager" },
    { value: "setup-local", description: "Fetch local development secrets from Secret Manager" },
    { value: "deploy", description: "Create and push a release tag to trigger deployment" },
  ]
}

def "nu-complete pit notifications" [] {
  [
    { value: "deploy", description: "Send deployment notification to Slack" },
  ]
}

def "nu-complete pit packages" [] {
  [
    { value: "build", description: "Build distribution packages" },
    { value: "link", description: "Link distribution packages for local development" },
    { value: "publish", description: "Publish all distribution packages with synchronized versioning" },
    { value: "unlink", description: "Unlink distribution packages" },
    { value: "upgrade", description: "Upgrade internal dist packages to their latest published versions" },
  ]
}

def "nu-complete pit pre" [] {
  [
    { value: "commit", description: "Runs the most important checks and tests for precommit" },
    { value: "flight", description: "Run all checks and tests (check all -> test all)" },
  ]
}

def "nu-complete pit scripts" [] {
  [
    { value: "pit-spec-pages-json-to-markdown", description: "Convert page specifications JSON to markdown format" },
    { value: "remove-node-modules", description: "Remove all node_modules directories in the monorepo" },
  ]
}

def "nu-complete pit serve" [] {
  [
    { value: "app", description: "Serve a frontend application" },
    { value: "service", description: "Serve backend services" },
  ]
}

def "nu-complete pit setup" [] {
  [
    { value: "setup", description: "Validate the development environment configuration (deprecated)" },
  ]
}

def "nu-complete pit sync" [] {
  [
    { value: "all", description: "Sync files across pit folders according to manifest fileSyncing rules" },
  ]
}

def "nu-complete pit templates" [] {
  [
    { value: "list", description: "List all available codegen templates" },
    { value: "usage", description: "Get detailed usage information for a codegen template" },
  ]
}

def "nu-complete pit test" [] {
  [
    { value: "all", description: "Run all tests (unit, integration-frontend, integration-backend, e2e-backend)" },
    { value: "unit", description: "Run unit tests (*.test.ts files)" },
    { value: "integration-frontend", description: "Run frontend integration tests (*.integration.frontend.test.ts files)" },
    { value: "integration-backend", description: "Run backend integration tests (*.integration.test.ts files)" },
    { value: "e2e-frontend", description: "Run frontend end-to-end tests (Playwright)" },
    { value: "e2e-backend", description: "Run backend end-to-end tests (Vitest)" },
    { value: "stage-migrations", description: "Test database migrations against Neon stage branches for affected customers" },
  ]
}

def "nu-complete pit worker" [] {
  [
    { value: "create", description: "Create worker pod pairs via the worker operator" },
    { value: "list", description: "List worker pods (optionally filter by customer)" },
    { value: "status", description: "Show sandbox pod status via port-forward" },
    { value: "run", description: "Run a workflow on a sandbox pod and stream events" },
  ]
}

def "nu-complete pit workflow" [] {
  [
    { value: "create-ui-preview", description: "Create a UI preview feature from a brief (app structure auto-generated if not provided)" },
    { value: "assess", description: "Assess pit folders against architectural guidelines" },
    { value: "submit-pr", description: "Submit a pull request from the current branch" },
    { value: "llm-fix", description: "Fix lint, type, and test errors using LLM" },
    { value: "task-research-plan-implement", description: "Research, plan, and implement a task using an LLM agent" },
    { value: "iterative-implement", description: "Iteratively implement a task with automated checking and judgment" },
    { value: "fix-todos", description: "Extract and fix TODO comments in the codebase" },
    { value: "multi-assess", description: "Assess multiple pit folders against architectural guidelines" },
    { value: "multi-pit-folder-apply", description: "Apply an LLM prompt to multiple pit folders" },
    { value: "manifest-review", description: "Review a manifest type for consistency and optionally create issues or implement fixes" },
    { value: "analyze-session", description: "Analyze workflow sessions for debugging and optimization" },
    { value: "reduce-package-complexity", description: "Reduce code complexity in a package through iterative LLM-based refactoring" },
    { value: "run-claude", description: "Execute Claude in agent mode with full codebase access" },
    { value: "implement", description: "Implement a task with iterative quality assurance using the Claude Code Agent SDK" },
    { value: "babysit", description: "Monitor a GitHub PR, fix CI failures and address review comments" },
  ]
}

export extern "pit" [
  command?: string@"nu-complete pit"
]

export extern "pit api" [
  subcommand?: string@"nu-complete pit api"
]

export extern "pit api workflow" [
  subcommand?: string@"nu-complete pit api workflow"
]

export extern "pit api workflow job" [
  subcommand?: string@"nu-complete pit api workflow job"
]

export extern "pit api workflow job list" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --limit
  --offset
  --organization-id
  --org-slug
  --status
]

export extern "pit api workflow job cancel" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
  --id
]

export extern "pit api workflow job steps" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
  --job-id
]

export extern "pit api workflow job logs" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
  --job-id
]

export extern "pit api orgs" [
  subcommand?: string@"nu-complete pit api orgs"
]

export extern "pit api orgs list" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --limit
  --offset
]

export extern "pit api orgs create" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --name
  --slug
]

export extern "pit api orgs update" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
  --name
  --slug
]

export extern "pit api orgs members" [
  subcommand?: string@"nu-complete pit api orgs members"
]

export extern "pit api orgs members list" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
]

export extern "pit api orgs members add" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
  --user-id
  --role
]

export extern "pit api orgs members invite" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
  --as-user-id
  --email
  --role
]

export extern "pit api orgs domains" [
  subcommand?: string@"nu-complete pit api orgs domains"
]

export extern "pit api orgs domains list" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
]

export extern "pit api orgs domains add" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
  --domain
]

export extern "pit api orgs domains remove" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --domain
]

export extern "pit api users" [
  subcommand?: string@"nu-complete pit api users"
]

export extern "pit api users set-active-org" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --user-id
  --organization-id
  --org-slug
]

export extern "pit api users list" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --limit
  --offset
]

export extern "pit api projects" [
  subcommand?: string@"nu-complete pit api projects"
]

export extern "pit api projects list" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --limit
  --offset
  --organization-id
  --org-slug
  --sort-by
]

export extern "pit api projects create" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
  --name
  --created-by
]

export extern "pit api config" [
  subcommand?: string@"nu-complete pit api config"
]

export extern "pit api config set-org" [
  --organization-id
]

export extern "pit api config get-org" []

export extern "pit api config set-user" [
  --user-id
]

export extern "pit api config get-user" []

export extern "pit api config set-key" [
  --api-key
  --env
  --host
]

export extern "pit api config show-key" [
  --env
  --host
]

export extern "pit api ui-preview" [
  subcommand?: string@"nu-complete pit api ui-preview"
]

export extern "pit api ui-preview push" [
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
  --project-id
  --branch-name
  --verbose
]

export extern "pit api ui-preview reset" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
  --project-id
  --force
  --purge
]

export extern "pit api studio" [
  subcommand?: string@"nu-complete pit api studio"
]

export extern "pit api studio sync-pull" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
]

export extern "pit api studio sync-push" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --as-user-id
]

export extern "pit api upload" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
  --as-user-id
]

export extern "pit api file-text" [
  --json
  --prod
  --stage
  --local
  --docker
  --host
  --organization-id
  --org-slug
]

export extern "pit artifactory" [
  subcommand?: string@"nu-complete pit artifactory"
]

export extern "pit artifactory status" [
  --json
]

export extern "pit artifactory jobs" [
  --json
  --template
  --phase
  --limit
]

export extern "pit artifactory get" [
  --json
]

export extern "pit artifactory logs" [
  --json
  --tail
  --follow
]

export extern "pit artifactory images" [
  --json
  --limit
]

export extern "pit artifactory build" [
  --json
]

export extern "pit build" [
  subcommand?: string@"nu-complete pit build"
]

export extern "pit build all" [
  --verbose
  --serial
]

export extern "pit build app" [
  --verbose
  --vite-base-path
  --serve
  --test-serve
]

export extern "pit build service" [
  --verbose
]

export extern "pit check" [
  subcommand?: string@"nu-complete pit check"
]

export extern "pit check all" [
  --fix
  --verbose
  --watch
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
  --serial
  --exclude-checks
]

export extern "pit check markdown-links" [
  --verbose
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit check manifests" [
  --fix
  --verbose
  --log-time
  --show-warnings
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit check routes-manifests" [
  --fix
  --verbose
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
  --feature
]

export extern "pit check empty-folders" [
  --fix
  --verbose
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit check env" [
  --fix
  --verbose
]

export extern "pit check lint" [
  --fix
  --verbose
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit check knip" [
  --verbose
  --include
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit check lockfile" [
  --fix
  --verbose
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit check migration" [
  --verbose
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
  --up-to-date
  --safe
  --journal
  --base-branch
]

export extern "pit check format" [
  --fix
  --verbose
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit check types" [
  --verbose
  --watch
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
  --serial
  --next
]

export extern "pit check unused-manifests" [
  --verbose
]

export extern "pit completions" [
  subcommand?: string@"nu-complete pit completions"
]

export extern "pit completions bash" []

export extern "pit completions zsh" []

export extern "pit completions fish" []

export extern "pit completions nushell" []

export extern "pit complexity" [
  subcommand?: string@"nu-complete pit complexity"
]

export extern "pit complexity analyze-files" [
  --verbose
  --json
  --score-cap
  --exclude-under
  --changed
  --manifest
  --packages
  --include-tests
  --limit
]

export extern "pit complexity analyze-packages" [
  --verbose
  --json
  --exclude-under
  --changed
  --manifest
  --include-tests
  --limit
]

export extern "pit customer-repository" [
  subcommand?: string@"nu-complete pit customer-repository"
]

export extern "pit customer-repository init" [
  --force
  --link
  --verbose
]

export extern "pit customer-repository validate" [
  --link
  --verbose
]

export extern "pit db" [
  subcommand?: string@"nu-complete pit db"
]

export extern "pit db create-template" [
  --verbose
  --service-name
  --all
  --template-name
]

export extern "pit db generate" [
  --verbose
  --service-name
  --all
  --custom
  --name
]

export extern "pit db push" [
  --verbose
  --service-name
]

export extern "pit db migrate" [
  --verbose
  --service-name
]

export extern "pit db studio" [
  --verbose
  --service-name
]

export extern "pit db reset" [
  --verbose
  --service-name
]

export extern "pit dependencies" [
  subcommand?: string@"nu-complete pit dependencies"
]

export extern "pit dependencies update-manifest" [
  --verbose
  --dry-run
]

export extern "pit dependencies upgrade" [
  --verbose
  --llm-fix
  --reset-plan
]

export extern "pit deploy" [
  subcommand?: string@"nu-complete pit deploy"
]

export extern "pit deploy create" [
  --json
  --type
  --image-name
  --dockerfile
  --auto-deploy-env
  --watch-paths
]

export extern "pit deploy destroy" [
  --json
  --yes
]

export extern "pit deploy list" [
  --json
  --customer
  --table
]

export extern "pit deploy get" [
  --json
]

export extern "pit deploy set" [
  --json
  --yes
  --branch
  --pr-number
  --pr-title
  --message
]

export extern "pit deploy delete" [
  --json
  --yes
]

export extern "pit deploy history" [
  --json
  --limit
]

export extern "pit deploy audit" [
  --json
  --env
  --action
  --user
  --since
  --limit
]

export extern "pit deploy rollback" [
  --json
  --yes
  --to-event-id
]

export extern "pit deploy status" [
  --json
  --customer
  --env
  --once
  --no-emoji
  --refresh-seconds
]

export extern "pit deploy config" [
  subcommand?: string@"nu-complete pit deploy config"
]

export extern "pit deploy config get" [
  --json
  --resolve
]

export extern "pit deploy config set" [
  --json
  --file
  --yes
  --secret
]

export extern "pit deploy config patch" [
  --json
  --file
  --yes
  --secret
]

export extern "pit deploy config delete-key" [
  --json
  --yes
]

export extern "pit deploy logs" [
  --json
  --follow
  --limit
  --severity
  --since
  --category
  --dry-run
]

export extern "pit dev" [
  subcommand?: string@"nu-complete pit dev"
]

export extern "pit dev all" [
  --verbose
  --print-config
  --default
]

export extern "pit dev app" [
  --verbose
  --print-config
  --default
]

export extern "pit dev service" [
  --verbose
  --print-config
  --default
]

export extern "pit editor" [
  subcommand?: string@"nu-complete pit editor"
]

export extern "pit editor open" [
  --verbose
  --force
  --repo-name
  --all
]

export extern "pit editor close" [
  --verbose
  --repo-name
  --all
]

export extern "pit evals" [
  subcommand?: string@"nu-complete pit evals"
]

export extern "pit evals run" [
  --verbose
  --watch
  --ui
  --update
]

export extern "pit evals comparison" [
  --verbose
  --model-1-provider
  --model-1-id
  --model-2-provider
  --model-2-id
  --runs
]

export extern "pit infra" [
  subcommand?: string@"nu-complete pit infra"
]

export extern "pit infra add-secret" [
  --name
  --value
  --update
  --comment
]

export extern "pit infra setup-local" [
  --override
]

export extern "pit infra deploy" [
  --list
  --limit
  --prod
  --pr
  --bump
  --yes
  --dry-run
  --verbose
]

export extern "pit notifications" [
  subcommand?: string@"nu-complete pit notifications"
]

export extern "pit notifications deploy" [
  --type
  --environment
  --version
  --commit-sha
  --workflow-url
  --app-url
  --customer
  --repository
]

export extern "pit packages" [
  subcommand?: string@"nu-complete pit packages"
]

export extern "pit packages build" [
  --verbose
]

export extern "pit packages link" [
  --verbose
]

export extern "pit packages publish" [
  --verbose
  --bump
  --dry-run
  --skip-auth
  --skip-build
  --bump-catalog
]

export extern "pit packages unlink" [
  --verbose
]

export extern "pit packages upgrade" [
  --verbose
  --dry-run
]

export extern "pit pre" [
  subcommand?: string@"nu-complete pit pre"
]

export extern "pit pre commit" [
  --fix
  --verbose
  --clear-cache
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
  --serial
]

export extern "pit pre flight" [
  --fix
  --verbose
  --clear-cache
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
  --serial
]

export extern "pit scripts" [
  subcommand?: string@"nu-complete pit scripts"
]

export extern "pit scripts pit-spec-pages-json-to-markdown" [
  --verbose
  --output
  --dry-run
]

export extern "pit scripts remove-node-modules" [
  --verbose
  --dry-run
]

export extern "pit serve" [
  subcommand?: string@"nu-complete pit serve"
]

export extern "pit serve app" [
  --verbose
  --build
]

export extern "pit serve service" [
  --verbose
  --build
]

export extern "pit setup" [
  subcommand?: string@"nu-complete pit setup"
]

export extern "pit setup setup" [
  --verbose
]

export extern "pit sync" [
  subcommand?: string@"nu-complete pit sync"
]

export extern "pit sync all" [
  --dry-run
  --verbose
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit templates" [
  subcommand?: string@"nu-complete pit templates"
]

export extern "pit templates list" [
  --verbose
]

export extern "pit templates usage" []

export extern "pit test" [
  subcommand?: string@"nu-complete pit test"
]

export extern "pit test all" [
  --verbose
  --watch
  --ui
  --update
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
  --serial
  --exclude-tests
]

export extern "pit test unit" [
  --verbose
  --watch
  --ui
  --update
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit test integration-frontend" [
  --verbose
  --watch
  --ui
  --update
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit test integration-backend" [
  --verbose
  --watch
  --ui
  --update
  --grep
  --filter
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
  --packages
  --skip-template-creation
  --coverage
]

export extern "pit test e2e-frontend" [
  --verbose
  --ui
  --headed
  --debug
  --skip-build-frontend
  --skip-template-creation
  --systems
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit test e2e-backend" [
  --verbose
  --watch
  --ui
  --update
  --docker
  --skip-template-creation
  --systems
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit test stage-migrations" [
  --verbose
  --customers
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
]

export extern "pit worker" [
  subcommand?: string@"nu-complete pit worker"
]

export extern "pit worker create" [
  --customer
  --env
  --desired-workers
  --branch
  --image-tag
  --main-service-host
]

export extern "pit worker list" [
  --customer
]

export extern "pit worker status" [
  --customer
  --pair
  --url
]

export extern "pit worker run" [
  --customer
  --input
  --branch
  --pair
  --url
]

export extern "pit workflow" [
  subcommand?: string@"nu-complete pit workflow"
]

export extern "pit workflow create-ui-preview" [
  --branch-name
  --brief
  --app-structure
  --model-provider
  --scaffold-only
  --ui-preview-base-url
  --git-disabled
  --mock
  --app-name
]

export extern "pit workflow assess" [
  --output-path
  --rating-cutoff
  --model-provider
]

export extern "pit workflow submit-pr" [
  --force
  --dry
  --model-provider
  --base-branch
  --auto-merge
  --llm-fix
  --draft
  --commit
]

export extern "pit workflow llm-fix" [
  --initial-error
  --max-iterations
  --model-provider
  --auto-commit
]

export extern "pit workflow task-research-plan-implement" [
  --task-description
  --max-turns-per-phase
  --skip-implement
  --skip-submit-pr
  --rpi-agent
  --reasoning
  --max-review-iterations
]

export extern "pit workflow iterative-implement" [
  --task-description
  --max-iterations
  --max-turns-per-step
]

export extern "pit workflow fix-todos" [
  --modules
  --backend
  --frontend
  --platform
  --apps
  --changed
  --module
  --paths
]

export extern "pit workflow multi-assess" [
  --manifest-type
  --output-path
  --rating-cutoff
  --model-provider
  --concurrency
]

export extern "pit workflow multi-pit-folder-apply" [
  --paths
  --manifest-type
  --names
  --prompt
  --autofix
  --strategy
  --submit-pr
  --max-turns
]

export extern "pit workflow manifest-review" [
  --create-issue
  --implement
  --max-turns
]

export extern "pit workflow analyze-session" [
  --session-path
  --model-provider
]

export extern "pit workflow reduce-package-complexity" [
  --package-name
  --score-cutoff
  --max-reduce-iterations
  --max-review-iterations
  --max-turns
  --skip-submit-pr
]

export extern "pit workflow run-claude" [
  --prompt
  --max-turns
]

export extern "pit workflow implement" [
  --prompt
  --continue
  --submit-pr
  --max-turns
  --max-iterations
]

export extern "pit workflow babysit" [
  --branch
  --max-iterations
  --poll-interval
  --max-wait-time
  --max-turns
]

export extern "pit wtf" [
  --verbose
  --dry-run
]
