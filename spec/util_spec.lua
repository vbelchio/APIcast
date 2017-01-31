local util = require 'util'

describe('util',function()
  describe('system', function()
    local system = util.system

    it('returns output', function()
      local output = system('echo true-output')
      assert.equal('true-output\n', output)
    end)

    it('returns error', function()
      local success, err, code = system('sh missing-file')

      assert.equal('', success)
      assert.truthy(err:find('sh:'))
      assert.truthy(err:find('missing%-file'))
      assert.truthy(code > 0)
    end)

    it('does not return stderr on success', function()
      local output = system('(>&2 echo error) && echo success')
      assert.equal('success\n', output)
    end)

    it('returns stderr on failure', function()
      local stdout, stderr = system('(>&2 echo error) && echo progress && false')
      assert.equal('error\n', stderr)
      assert.equal('progress\n', stdout)
    end)
  end)

  describe('format_public_key', function()
    it('works with nil', function()
      assert.equal(nil, util.format_public_key())
    end)
  end)
end)
