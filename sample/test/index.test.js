import assert from "assert";
import { codeCoveredByTests } from "../index.js";

describe('index', () => {
  it("coverage test", () => {
    const value = codeCoveredByTests();

    assert.strictEqual(value, "covered")
  })
})
