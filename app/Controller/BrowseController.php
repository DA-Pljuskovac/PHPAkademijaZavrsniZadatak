<?php

declare(strict_types=1);

namespace App\Controller;

use App\Model\Post;
use App\Model\Review;
use App\Model\Search;
class BrowseController extends AbstractController
{
    public function indexAction()
    {
        return $this->view->render('browse', [
            'movie' => Post::getAll()
        ]);
    }
    public function pageAction()
    {
        $postId=$_GET['id'];
        $total_records_per_page=$_GET['num'];
        if ($postId==1)
        {
            return $this->view->render('page',[
                'movie'=> Post::getAll('mov_id',[$postId-1,$total_records_per_page])
            ]);
        } else
        {
            return $this->view->render('page',[
                'movie'=> Post::getAll('mov_id',[$total_records_per_page*($postId-1),$total_records_per_page])
            ]);
        }
    }
}
