<?php

declare(strict_types=1);

namespace App\Model;
use App\Core\Database;
use App\Core\DataObject;
class Voted extends AbstractModel
{
    protected static $tableName = 'has_voted';
    public static function change(string $column,$id, $value)
    {
        $tableName = static :: getTableName();
        $sql = "UPDATE {$tableName} SET {$column}={$value} WHERE rev_id ={$id} ";
        $statement = Database::getInstance()->prepare($sql);
        $statement->bindValue('value', $value);
        $statement->execute();
    }
}
