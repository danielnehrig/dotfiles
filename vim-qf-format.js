class JestVimReporter {
        onTestResult(test, { testResults }) {
                testResults.forEach(test => {
                        if (test.status !== 'failed') return;
                        // note: I couldn't find out how to make a test generate more than one
                        // failure message
                        //
                        // Test objects look like this:
                        //
                        // console.log(test)
                        // { ancestorTitles: [ 'some describe title' ],
                        // duration: 3,
                        // failureMessages:
                        //  [ 'Error: \u001b[2mexpect(\u001b[22m\u001b[31mreceived\u001b[39m\u001b[2m).toBeTruthy(\u001b[22m\u001b[2m)\u001b[22m\n\nReceived: \u001b[31mfalse\u001b[39m\n    at Object.toBeTruthy (/Users/olalonde/code/vim-test-jest-clean-qf-reporter/index.test.js:7:19)\n    at Object.asyncJestTest (/Users/olalonde/code/vim-test-jest-clean-qf-reporter/node_modules/jest-jasmine2/build/jasmine_async.js:108:37)\n    at resolve (/Users/olalonde/code/vim-test-jest-clean-qf-reporter/node_modules/jest-jasmine2/build/queue_runner.js:56:12)\n    at new Promise (<anonymous>)\n    at mapper (/Users/olalonde/code/vim-test-jest-clean-qf-reporter/node_modules/jest-jasmine2/build/queue_runner.js:43:19)\n    at promise.then (/Users/olalonde/code/vim-test-jest-clean-qf-reporter/node_modules/jest-jasmine2/build/queue_runner.js:87:41)\n    at process._tickCallback (internal/process/next_tick.js:68:7)' ],
                        // fullName: 'some describe title this will fail',
                        // location: null,
                        // numPassingAsserts: 0,
                        // status: 'failed',
                        // title: 'this will fail' }

                        test.failureMessages.forEach(failureMessage => {
                                const msg = failureMessage
                                        .replace(/\n/g, ' ')
                                        .replace(/.*?(?=Expected)(.*?)at .*?\((.*?)\).*/, '$1\n($2)')
                                        .replace(/.*?(?=Error)(.*?)at .*?\((.*?)\).*/, '$1\n($2)')
                                        .replace(/ +/g, ' ')
                                        .trim();

                                const lines = msg.split('\n');
                                if (lines.length !== 2) {
                                        console.error(
                                                'vim-test-jest-clean-qf-reporter: could not parse error.'
                                        );
                                        console.error(
                                                'Report this issue here: https://github.com/ajcrites/vim-test-jest-clean-qf-reporter/issues'
                                        );
                                        console.error(failureMessage);
                                } else {
                                        const [line1, line2] = lines;
                                        const msg = line1.trim();
                                        const location = line2.replace(/^[ ]*\(/, '').replace(/\)[ ]*/, '');
                                        //const location = line2;
                                        console.log(test.fullName)
                                        console.log(`${location}: ${msg}`);
                                }
                        });
                });
        }
}

module.exports = JestVimReporter;
