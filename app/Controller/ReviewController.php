<?php

declare(strict_types=1);

namespace App\Controller;

use App\Model\Review;
use App\Model\Post;
use App\Model\Moviecast;
use App\Model\Up;
use App\Model\Down;
use App\Model\Director;
use App\Model\Genres;
class ReviewController extends AbstractController
{
    public function createAction()
    {
        if (!$this->isPost() || !$this->auth->isLoggedIn()) {
            header('Location: /');
            return;
        }

        $postContent = $_POST['new_review'] ?? '';

        if (!$postContent) {
            // set error message
            header('Location: /');
            return;
        }
        Review::insert([
            'rev_name'=>$this->auth->getCurrentUser()->getFirstName().' '.$this->auth->getCurrentUser()->getLastName(),
            'rev_content'=>$postContent,
            'rev_mov_id'=>$_POST['mov_id'],
            'rev_score'=>$_POST['review_rating'],
            'rev_up'=>0,
            'rev_down'=>0,
        ]);
        header("Location: /review/details?id={$_POST['mov_id']}");
    }

    public function deleteAction()
    {
        $postId = $_GET['id'] ?? null;
        if (!$postId || !$this->auth->isLoggedIn()) {
            header('Location: /');
            return;
        }

        $post = Review::getOne('id', $postId);

        if ($post->getUserId() == $this->auth->getCurrentUser()->getId()) {
            Review::delete('id', $postId);
        }

        header('Location: /');
    }
    public function detailsAction()
    {
        $postId=$_GET['id'] ?? null;
        if( !$postId){
            header('Location: /');
            return;
        }
        return $this->view->render('details',['movie'=>Post::getOne('mov_id',$postId),'review'=>Review::getMultiple('rev_mov_id',$postId),'actor'=>Moviecast::getMultiple('mov_id',$postId),'director'=>Director::getMultiple('mov_id',$postId),'movie_genres'=>Genres::getMultiple('mov_id',$postId)]);
    }
    public function upAction()
    {
        $postId=$_POST['id'] ?? null;
        if (!$postId){
            header('Location: /');
            return;
        }
        Up::up('rev_up',$postId,1);
        header ("Location: /review/details?id={$_POST['mov_id']}");
    }
    public function downAction()
    {
        $postId=$_POST['id'] ?? null;
        if (!$postId){
            header('Location: /');
            return;
        }
        Down::down('rev_down',$postId,1);
        header ("Location: /review/details?id={$_POST['mov_id']}");
    }

}
