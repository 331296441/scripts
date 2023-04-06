你可以使用Redis中的有序集合（Sorted Set）来实现这个功能。在有序集合中，每个元素都有一个分数（Score），你可以将元素的过期时间作为分数，然后使用Redis的`ZREMRANGEBYSCORE`命令来删除过期的元素。以下是一个示例代码：

```java
import redis.clients.jedis.Jedis;
import redis.clients.jedis.Tuple;

import java.util.Set;

public class ExpireList {
    private Jedis jedis;
    private String key;

    public ExpireList(Jedis jedis, String key) {
        this.jedis = jedis;
        this.key = key;
    }

    public void add(String element, long expireTime) {
        jedis.zadd(key, expireTime, element);
    }

    public void update(String element, long expireTime) {
        jedis.zadd(key, expireTime, element);
    }

    public void remove(String element) {
        jedis.zrem(key, element);
    }

    public void removeExpired() {
        long now = System.currentTimeMillis();
        jedis.zremrangeByScore(key, 0, now);
    }

    public Set<Tuple> getAll() {
        return jedis.zrangeWithScores(key, 0, -1);
    }
}
```

在上面的代码中，我们定义了一个`ExpireList`类，它封装了一个有序集合，并提供了添加、更新、删除和删除过期元素的方法。在`add`和`update`方法中，我们使用`zadd`命令将元素添加到有序集合中，并将元素的过期时间作为分数。在`remove`方法中，我们使用`zrem`命令从有序集合中删除指定的元素。在`removeExpired`方法中，我们使用`zremrangeByScore`命令删除所有过期的元素。在`getAll`方法中，我们使用`zrangeWithScores`命令获取有序集合中的所有元素和分数。

以下是一个使用`ExpireList`类的示例代码：

```java
import redis.clients.jedis.Jedis;
import redis.clients.jedis.Tuple;

import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Jedis jedis = new Jedis("localhost");
        ExpireList list = new ExpireList(jedis, "mylist");

        // 添加元素
        list.add("foo", System.currentTimeMillis() + 10000);
        list.add("bar", System.currentTimeMillis() + 20000);

        // 更新元素
        list.update("foo", System.currentTimeMillis() + 30000);

        // 删除元素
        list.remove("bar");

        // 删除过期元素
        list.removeExpired();

        // 获取所有元素
        Set<Tuple> elements = list.getAll();
        for (Tuple element : elements) {
            System.out.println(element.getElement() + ": " + element.getScore());
        }
    }
}
```

在上面的代码中，我们首先创建了一个`Jedis`对象，并使用它创建了一个`ExpireList`对象。然后，我们向`ExpireList`对象中添加、更新和删除了一些元素，并删除了过期元素。最后，我们使用`getAll`方法获取了所有元素，并输出了它们的值和过期时间。