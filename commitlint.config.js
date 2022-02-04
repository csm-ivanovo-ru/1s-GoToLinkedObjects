module.exports = {
	rules: {
		// https://commitlint.js.org/#/reference-rules

		"body-leading-blank": [2, "always"],
		"body-max-line-length": [0, "always", 72],
		"footer-leading-blank": [2, "always"],
		"footer-max-line-length": [2, "always", 72],
		"header-max-length": [1, "always", 72],
		"header-case": [0, "always", "sentence-case"],
		"type-case": [2, "always", "lower-case"],
		"type-empty": [2, "never"],
		"type-enum": [2, "always", [
			"feat",
			"update",
			"fix",
			"chore",
			"docs",
			"style",
			"refactor",
			"perf",
			"ci",
			"test",
			"revert",
			"wip",
			"init"
		]],
		"scope-case": [2, "always", "lower-case"],
		"scope-enum": [1, "always", [
			"ext",
			"vscode",
			"git",
			"github",
			"github-actions",
			"deps",
			"other",
			"changelog",
			"readme"
		]],
		"scope-empty": [1, "never"],
		"subject-case": [1, "always", "sentence-case"],
		"subject-empty": [2, "never"],
		"subject-full-stop": [2, "never", "."],
		"subject-max-length": [1, "always", 72],
	}
};
