<?php

namespace App\Api\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class OrderController extends AbstractController
{
    #[Route('/api/order/create', name: 'api_order_create', methods: ['GET'])]
    public function create(): Response
    {
        return $this->json(['success' => true, 'message' => 'Order created successfully']);
    }
}
