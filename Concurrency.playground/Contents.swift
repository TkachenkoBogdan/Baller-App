import UIKit

// MARK: - Hometask 3:

// Deadlock with two queues:

//#1

do {

    let serialQueueA = DispatchQueue(label: "com.bogdantkachenko.queueA", qos: .default, attributes: .initiallyInactive)
    let serialQueueB = DispatchQueue(label: "com.bogdantkachenko.queueB", qos: .default, attributes: .initiallyInactive)

    serialQueueA.setTarget(queue: serialQueueB)
    serialQueueB.setTarget(queue: serialQueueA)

    [serialQueueA, serialQueueB].forEach { $0.activate()}

    serialQueueA.async {
        print("Item Completed.")
    }
}


//#2

do {

    var resource = 666

    let serialQueueA = DispatchQueue(label: "com.bogdantkachenko.queueA")
    let concurrentQueueB = DispatchQueue(label: "com.bogdantkachenko.queueB", qos: .default, attributes: .concurrent)

    let semaphore = DispatchSemaphore(value: 1)

    let item = DispatchWorkItem {
        semaphore.wait()

        print(resource)

        serialQueueA.sync {
            semaphore.wait()
            resource += 1
            print(resource)
            semaphore.signal()
        }

        semaphore.signal()
        print("Item completed")
    }

    concurrentQueueB.async(execute: item)

}

 //Cancellation:

do {

    let queue = DispatchQueue.global(qos: .background)
    var item: DispatchWorkItem!

    item = DispatchWorkItem {

        while true {
            if item.isCancelled { break }
            print("0")
        }

    }

    queue.async(execute: item)

    queue.asyncAfter(deadline: .now() + 2) { [weak item] in
        item?.cancel()
        print("Item cancelled")
    }

}
