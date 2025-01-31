import express from "express";
import {
  addOrderItems,
  getMyOrders,
  getorderById,
  updateOrderToDelivered,
  updateOrderToPaid,
  getOrders,
} from "../controllers/orderController.js";

import { protect, admin } from "../middleware/authMiddleware.js";

const router = express.Router();

router.route("/").post(protect, addOrderItems).get(protect, admin, getOrders);
router.route("/mine").get(protect, getMyOrders);
router.route("/:id").get(protect, getorderById);
router.route("/:id/pay").get(protect, updateOrderToPaid);
router.route("/:id/deliver").get(protect, admin, updateOrderToDelivered);

export default router;
