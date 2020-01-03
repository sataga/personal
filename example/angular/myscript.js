var mainCtrl = function ($scope) {
    $scope.tasks = [
        { "body": "do this 1", "done": false },
        { "body": "do this 2", "done": false },
        { "body": "do this 3", "done": true },
        { "body": "do this 4", "done": false }
    ];
    $scope.addNew = function () {
        $scope.tasks.push({ "body": $scope.newTaskBody, "done": false });
        $scope.newTaskBody = '';
    }
    $scope.getDoneCount = function () {
        var count = 0;
        angular.forEach($scope.tasks, function (task) {
            count += task.done ? 1 : 0;
        });
        return count;
    }
    $scope.deleteDone = function () {
        var oldTasks = $scope.tasks;
        $scope.tasks = [];
        angular.forEach(oldTasks, function (task) {
            if (!task.done) $scope.tasks.push(task);
        });
    }
}
