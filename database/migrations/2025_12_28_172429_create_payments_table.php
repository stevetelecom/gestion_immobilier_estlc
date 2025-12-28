<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->string('payment_number')->unique();
            $table->foreignId('contract_id')->constrained()->onDelete('cascade');
            $table->foreignId('tenant_id')->constrained('users')->onDelete('cascade');
            
            $table->decimal('amount', 10, 2);
            $table->date('payment_date');
            $table->date('due_date');
            
            $table->enum('payment_method', ['especes', 'virement', 'cheque', 'mobile_money', 'carte_bancaire']);
            $table->string('transaction_reference')->nullable();
            
            $table->enum('type', ['loyer', 'caution', 'charges', 'frais_agence', 'autre']);
            $table->enum('status', ['en_attente', 'paye', 'en_retard', 'annule'])->default('en_attente');
            
            $table->text('notes')->nullable();
            $table->string('receipt_file')->nullable();
            
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
